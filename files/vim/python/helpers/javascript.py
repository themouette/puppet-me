import re

def classname(snip):
    name = snip.fn[:1].capitalize() + snip.fn[1:]
    return name.split('.')[0]

def parse_args(args, snip):
    pattern = '\s*(?P<param>[^,=\s]+)';
    ret = []

    prefix = '\n' + snip.mkline(" * ")

    for arg in args.split(','):
        matches = re.match(pattern, arg)
        if matches:
            groups = matches.groupdict()
            param = format_arg(groups['param'])

            ret.append(param)

    return prefix.join(ret)

def format_arg(paramname):
    return "@param {0}".format(paramname).rstrip()

if __name__ == '__main__':
    import unittest

    class TestPhpSnippets(unittest.TestCase):

        def setUp(self):
            self.snip = Snip()

        def assertParseArgs(self, args, expected):
            self.assertEqual(expected, parse_args(args, self.snip))

        def test_empty(self):
            self.assertParseArgs('', '')

        def test_simple(self):
            self.assertParseArgs('$foo', '@param $foo')

        def test_multiple(self):
            self.assertParseArgs('foo,\nbar  , baz',
"""@param foo
 * @param bar
 * @param baz"""
            )

    class Snip:
        def mkline(self, x):
            return x

    unittest.main()
