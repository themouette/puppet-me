import re

def namespace(realpath):
    path = re.split('/|\\\\', realpath);
    path.pop()  # remove filename
    parts = []
    while len(path):
        part = path.pop()
        if ['lib', 'src'].count(part):
            break;
        parts.insert(0, part)
    return '\\'.join(parts)

def classname(snip):
    name = snip.fn[:1].capitalize() + snip.fn[1:]
    return name.split('.')[0]

def parse_args(args, snip):
    pattern = '\s*(?P<sig>[^,=\s]+)?\s*\$(?P<param>[^,=\s]+)\s*=?\s*(?P<default>[^,\s]*)';
    ret = []

    prefix = '\n' + snip.mkline(" * ")

    for arg in args.split(','):
        matches = re.match(pattern, arg)
        if matches:
            groups = matches.groupdict()
            param = format_arg(
                            groups['sig'] if 'sig' in groups and groups['sig'] else 'Mixed',
                            groups['param'],
                            groups['default'] if 'default' in groups and groups['default'] else '')

            ret.append(param)

    return prefix.join(ret)

def format_arg(signature, paramname, default):
    return "@param {:<10}${:<9}{:}".format(
            signature, paramname, default).rstrip()

if __name__ == '__main__':
    import unittest

    class TestNamespace(unittest.TestCase):

        def setUp(self):
            self.snip = Snip()

        def test_empty(self):
            self.assertEquals('', namespace(''))
            # TODO: change this behavior
            self.assertEquals('\\home\\julien\\workspace\\Foo', namespace('/home/julien/workspace/Foo/bar.php'))

        def test_src(self):
            self.assertEquals('Foo', namespace('/home/julien/workspace/src/Foo/bar.php'))
            self.assertEquals('Acme\\Bundle', namespace('/home/julien/workspace/src/Acme/Bundle/bar.php'))

        def test_lib(self):
            self.assertEquals('Foo', namespace('/home/julien/workspace/lib/Foo/bar.php'))
            self.assertEquals('Acme\\Bundle', namespace('/home/julien/workspace/lib/Acme/Bundle/bar.php'))

    class TestParseArgs(unittest.TestCase):

        def setUp(self):
            self.snip = Snip()

        def assertParseArgs(self, args, expected):
            self.assertEqual(expected, parse_args(args, self.snip))

        def test_empty(self):
            self.assertParseArgs('', '')

        def test_simple(self):
            self.assertParseArgs('$foo', '@param Mixed     $foo')

        def test_pseudotype(self):
            self.assertParseArgs('Callable $foo', '@param Callable  $foo')

        def test_default(self):
            self.assertParseArgs('$foo = "bar"', '@param Mixed     $foo      "bar"')

        def test_all(self):
            self.assertParseArgs('Callable   $foo = "bar"', '@param Callable  $foo      "bar"')

        def test_multiple(self):
            self.assertParseArgs('Callable $foo = "bar",\n$foo = "bar", $foo',
"""@param Callable  $foo      "bar"
 * @param Mixed     $foo      "bar"
 * @param Mixed     $foo"""
            )

    class Snip:
        def mkline(self, x):
            return x

    unittest.main()
