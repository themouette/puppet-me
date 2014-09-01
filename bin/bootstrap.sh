#!/usr/bin/env bash
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )/.." && pwd )"

function usage {
    echo "$0 [--module-path /path/to/modules]"
    echo ""
    echo "  Options:"
    echo "    -h, --help                        this help"
    echo "    -m, --modulepath <modulepath>     specify path to module directory"
    echo "    --skip-puppet-modules             skip puppet modules installation (if not in forge)"
    echo ""
}

# default options
OPT_MODULEPATH=""
# compute the default module location
MODULEPATH=$(puppet config print modulepath | cut -d":" -f1)
INSTALL_PUPPET_MODULES=true

function parse_options {
    SHORT_OPT="m:h"
    LONG_OPT="modulepath:,help,skip-puppet-modules"
    # parse arguments
    OPTS=$( getopt -o "$SHORT_OPT" -l "$LONG_OPT" -- "$@" )
    if  [ $? != 0 ]; then
        usage;
        exit 1;
    fi
    eval set -- "$OPTS"

    # read options
    while true ; do
        case "$1" in
            -m|--modulepath)
                # override module path
                OPT_MODULEPATH="$2"
                MODULEPATH="$2"
                shift 2;;
            -h|--help) usage
                exit 0;;
            --skip-puppet-modules) INSTALL_PUPPET_MODULES=false
                shift;;
            --) shift
                break;;
        esac
    done
}


function log {
    echo -e " \033[32m*\033[0m ${1}"
}
function error {
    echo -e "\033[31m${1}\033[0m"
}


function check_deps {
    log "update git submodules"
    git submodule update --init

    log "check bundler is available"
    if [ -z "$(which bundle)" ] ;
    then
        if [ -z "$(which gem)" ] ;
        then
            error "Ruby and gem are required (install with ruby executable in your path)"
            exit 1;
        fi

        log "Install bundler."
        sudo gem install bundler
    fi

    if [ -z "$(which puppet)" ]; then
        error "⚠ Puppet must be installed.\nUse 'PUPPET_VERSION=2.7.25 DISTRIBUTION=saucy bin/puppet.sh'"
        error "List of available releases at http://apt.puppetlabs.com/"
        exit 1;
    fi
}

function install_gem {
    if [ -e "${DIR}/Gemfile" ]
    then
        log "Install gem files";
        bundle install
    else
        log "No Gemfile found"
    fi
}



function install_modules {
    # should installation be skipped ?
    [[ $INSTALL_PUPPET_MODULES != true ]] && return 0
    log "Install puppet modules";
    # default puppet module install arguments
    ARGUMENTS=""

    if [ -n "$OPT_MODULEPATH" ]
    then
        # append the modulepath to arguments
        ARGUMENTS="$ARGUMENTS --modulepath $OPT_MODULEPATH"
    fi

    # parse Modulefile to install dependencies localy or widely
    #
    # 1. extract dependencies from Modulefile.
    # 2. split dependencies around ' and / to extract:
    #       * $2 module namespace
    #       * $3 module name
    #       * $5 version (eventualy)
    # 3. generate a "`if` module is not available" wrapped `puppet module
    #    install` command
    # 4. execute each line through `bash -c`. `xargs -t` means echo command first.
    grep  ^dependency Modulefile \
        | sed -e "s:\(\"\|'\)\(>\|<\)\?=\?\s*:\1:g" \
        | awk -v args="$ARGUMENTS" -v modules="$MODULEPATH" -F "[/']" \
            '{ if ($5 != "") {$5 = " --version \\\""$5"\\\""}; \
             { print \
                 "if [ ! -d \\\""modules"/"$3"\\\" ] ; then \
                    puppet module install "args" "$2"/"$3$5"; \
                  fi;\
            "}}' \
        | xargs -I'{}' -t bash -c '{}'
}

function link_to_modulepath {
    if [ ! -e "$MODULEPATH/me" ]
    then
        log "Link local module into puppet module path."
        ln -s "$DIR" "$MODULEPATH/me"
    fi
}

function link_ssh {
    if [ ! -e "$MODULEPATH/me/files/ssh" ]
    then
        log "Link local module into puppet module path."
        ln -s $HOME/.ssh "$DIR/files/ssh"
    fi
}



function install {
    check_deps
    install_gem
    install_modules
    link_to_modulepath
    link_ssh
}

parse_options "$@"
install

echo "Done."
