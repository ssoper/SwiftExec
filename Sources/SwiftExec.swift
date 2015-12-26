#if os(Linux)
    import Glibc
#else
    import Darwin.C
#endif

import Foundation

public func swiftExec(cmd: String, cmdArgs: String...) -> String {

    #if os(Linux)
        var output = ""
        let joinedArgs = cmdArgs.joinWithSeparator(" ")
        let fullCmd = "\(cmd) \(joinedArgs)"
        let fp = popen(fullCmd, "r")
        var buf = Array<CChar>(count: 128, repeatedValue: 0)

        while fgets(&buf, CInt(buf.count), fp) != nil,
              let str = String.fromCString(buf) {
            output += str
        }

        fclose(fp)
        return output
    #else
        let task = NSTask()
        task.launchPath = cmd
        task.arguments = cmdArgs

        let pipe = NSPipe()
        task.standardOutput = pipe
        task.launch()

        let data = pipe.fileHandleForReading.readDataToEndOfFile()
        let output = String(data: data, encoding: NSUTF8StringEncoding)
        return output!
    #endif
}
