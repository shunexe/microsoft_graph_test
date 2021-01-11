const fs = require("fs");

try {
    const buff = fs.readFileSync("cookie.txt", "utf8");
    const splitLines = buff.split('\n')
    const lineLength = splitLines.length
    const lastLine = splitLines[lineLength -2]
    const splitLine = lastLine.split('\t')
    const lastSplitLineIndex = splitLine.length -1
    const authenticationCode = splitLine[lastSplitLineIndex]
    console.log(authenticationCode)
}
catch(e) {
    console.log(e.message);
}
