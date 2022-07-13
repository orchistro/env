import sys, os

if __name__ == '__main__':
    if len(sys.argv) != 3:
        print >>sys.stderr, "Usage:", os.path.basename(__file__), "inputfile splitfactor"
        sys.exit(1)

    filename = sys.argv[1]
    splitfactor = sys.argv[2]
    splitfactor = int(splitfactor)

    outfilefd = []
    outfilename = []

    for i in range(splitfactor):
        outfilename.append(filename + "." + str(i + 1))

    for name in outfilename:
        outfilefd.append(open(name, "w"))

    i = 0
    for user in open(filename, "r"):
        outfilefd[i].write(user)
        i = i + 1
        if i >= splitfactor:
            i = 0

    for fd in outfilefd:
        fd.close()
