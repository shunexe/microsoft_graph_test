const arg = process.argv[2]

const newArg = arg.replace(/\[/,'').replace(/\]/,'').replace(/\s+/g, "")
const eventList = newArg.split(',')
console.log(eventList)

const weeklyList = eventList.filter(event => event.includes("週次"))
console.log(weeklyList)

const tecWeeklyList = eventList.filter(event => event.includes("TECWeekly"))
console.log(tecWeeklyList)







