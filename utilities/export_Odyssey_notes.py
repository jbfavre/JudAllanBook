#!/usr/bin/env python
# -*- coding: utf-8 -*-

__license__     = 'GPLv3'
__author__      = 'Alberto Pettarin (pettarin gmail.com)'
__copyright__   = '2012, 2013 Alberto Pettarin (pettarin gmail.com)'
__version__     = 'v1.02'
__date__        = '2013-05-11'
__description__ = 'Extract highlights and annotations from Odyssey .annot files'


### BEGIN changelog ###
#
# 1.02 2013-05-11 Better usage text
# 1.01 2013-05-04 Initial release
#
### END changelog ###

import getopt, os, sqlite3, sys 
from lxml import etree

ANNOTATION="annotation"
HIGHLIGHT="highlight"


### BEGIN read_command_line_parameters ###
# read_command_line_parameters(argv)
# read the command line parameters given in argv, and return a suitable dict()
def read_command_line_parameters(argv):

    try:
        optlist, free = getopt.getopt(argv[1:], 'chf:o:', ['file=', 'output=', 'csv', 'help'])
    #Python2#
    except getopt.GetoptError, err:
    #Python3#    except getopt.GetoptError as err:
        print_error(str(err))

    return dict(optlist)
### END read_command_line_parameters ###


### BEGIN usage ###
# usage()
# print script usage
def usage():
    #Python2#
    e = "python"
    #Python2#
    s = sys.argv[0] 
    #Python3#    e = "python3"
    #Python3#    s = sys.argv[0]
    print_("")
    print_("$ %s %s [ARGUMENTS]" % (e, s))
    print_("")
    print_("Arguments:")
    print_(" -h, --help          : print this usage message and exit")
    print_(" -f, --file <file>   : <file> is the path to .annot file")
    print_(" -c, --csv           : output CSV values, instead of human-readable strings")
    print_(" -o, --output <file> : write output to <file>")
    print_("")
    print_("Exit codes:")
    print_("")
    print_(" 0 = no error")
    print_(" 1 = invalid argument(s) error")
    print_(" 2 = specified file not found")
    print_(" 4 = provided file is not a valid .annot file")
    print_(" 8 = output file cannot be written")
    print_("")
    print_("Examples:")
    print_("")
    print_(" 1. Print this usage message")
    print_("    $ %s %s -h" % (e, s))
    print_("")
    print_(" 2. Print annotations and highlit passages in human-readable form")
    print_("    $ %s %s -f ebook.epub.annot" % (e, s))
    print_("")
    print_(" 3. As above, but output to output.txt")
    print_("    $ %s %s -f ebook.epub.annot -o output.txt" % (e, s))
    print_("")
    print_(" 4. As above, but output in CSV form")
    print_("    $ %s %s -c -f ebook.epub.annot" % (e, s))
    print_("")
    print_(" 5. As above, but output to output.csv")
    print_("    $ %s %s -c -f ebook.epub.annot -o output.csv" % (e, s))
    print_("")
### END usage ###


### BEGIN print_error ###
# print_error(error, displayusage=True)
# print the given error, call usage, and exit
# optional displayusage to skip usage
def print_error(error, displayusage = True, exitcode = 1):
    sys.stderr.write("[ERROR] " + error + " Aborting.\n")
    if displayusage :
        usage()
    sys.exit(exitcode)
### END print_error ###


### BEGIN print_info ###
# print_info(info, quiet)
# print the given info string
def print_info(info, quiet):
    if (not quiet):
        print("[INFO] " + info)
### END print_info ###


### BEGIN print_ ###
# print_(info)
# print the given string
def print_(info):
    print(info)
### END print_ ###


### BEGIN escape ###
# escape(s)
# escape ASCII sequences
def escape(s):
    if ((s == None) or (len(s) < 1)):
        return ""

    repl = [
            ["\0", "\\0"],
            ["\a", "\\a"],
            ["\b", "\\b"],
            ["\t", " "],
            ["\n", "\\n"],
            ["\v", "\\v"],
            ["\f", "\\f"],
            ["\r", "\\r"]
            ]
    for r in repl:
        s = s.replace(r[0], r[1])
    return s
### END escape ###


### BEGIN print_hr ###
# print_hr(data)
# data = [ [f_type, text, annotation, date] ]
# print human-readable output
def print_hr(data):

    acc = ""
    
    for d in data:
        [f_type, text, annotation, date] = d

        if (f_type == ANNOTATION):
            acc += "Type: %s\n" % (f_type)
            acc += "Reference text: %s\n" % (text)
            acc += "Annotation: %s\n" % (annotation)
            acc += "Date: %s\n" % (date)
            acc += "\n"

        if (f_type == HIGHLIGHT):
            acc += "Type: %s\n" % (f_type)
            acc += "Reference text: %s\n" % (text)
            acc += "Date: %s\n" % (date)
            acc += "\n"

    return acc.strip()
### END print_hr ###


### BEGIN print_csv ###
# print_csv(data)
# data = [ [f_type, text, annotation, date] ]
# print csv output
def print_csv(data):
    
    # add header
    data2 = [ ["Type", "Reference Text", "Annotation", "Date"] ] + data
    
    acc = ""

    for d in data2:
        acc += "%s\t%s\t%s\t%s\n" % (tuple(d))

    return acc.strip()
### END print_csv ###

### BEGIN main ###
def main():
    # read command line parameters
    options = read_command_line_parameters(sys.argv)

    # if help required, print usage and exit
    if (('-h' in options) or ('--help' in options)):
        usage()
        sys.exit(0)

    # look for dbFile
    dbFile = None
    if ('-f' in options):
        dbFile = options['-f']
    if ('--file' in options):
        dbFile = options['--file']
    
    if (dbFile == None):
        print_error("You should specify the path to a .annot file.", exitcode=1)
    if ('-f' in options) and ('--file' in options):
        print_error("You cannot specify both '%s' and '%s' parameters." % ('-f', '--file'), exitcode=1)
    if (not os.path.isfile(dbFile)):
        print_error("File %s not found." % (dbFile), exitcode=2)

    # look for CSV switch
    outputCSV = False
    if ('-c' in options) or ('--csv' in options):
        outputCSV = True

    # look for outFile
    outFile = None
    if ('-o' in options):
        outFile = options['-o']
    if ('--output' in options):
        outFile = options['--output']
    
    # get data
    acc = []
    # good, we can try opening the given file
    try:
        #f = open(dbFile, 'w')
        #content = f.read()
        #f.close()

        tree = etree.parse(dbFile)
        root = tree.getroot()
        
        NS = "{http://ns.adobe.com/digitaleditions/annotations}"

        timestamps = root.find(NS + "timestamps")
        date = timestamps.find(NS + "timestamp").get("value")

        annots = root.findall(NS + "annotation")
        for annot in annots:
            text = escape(annot.find(NS + "target").find(NS + "fragment").find(NS + "text").text)
            annotation = escape(annot.find(NS + "content").find(NS + "text").text)
            
            f_type = HIGHLIGHT
            if (annotation != ""):
                f_type = ANNOTATION

            acc.append([f_type, text, annotation, date])
    except:
        print_error("File %s is not a valid .annot file." % (dbFile), exitcode=4)

    # output stuff to stdout
    if (outputCSV):
        output = print_csv(acc)
    else:
        output = print_hr(acc)

    # output to stdout or file?
    if (outFile == None):
        # stdout
        print_(output)
    else:
        # file
        try:
            f = open(outFile, 'w')
            f.write(output)
            f.close()
        except:
            print_error("File %s cannot be written." % (outFile), exitcode=8)

    # return proper exit code
    sys.exit(0)
### END main ###



if __name__ == '__main__':
    # TODO let the user specify file encoding instead
    #Python2#
    reload(sys)
    #Python2#
    sys.setdefaultencoding("utf-8")
    main()

