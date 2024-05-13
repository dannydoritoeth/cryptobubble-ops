//@version=5
indicator("Uniswap S2F Rainbow Chart", overlay=true, scale=scale.right)

// Constants for total and initial supplies
totalSupply = 1000000000
initialTeam = totalSupply * 2.08 / 100
initialInvestors = 180440000  // Assuming this was meant to be 180.44M
initialAdvisors = totalSupply * 2.08 / 100
communityTokens = 150000000
untracked = 450000000

// Input for TGE date using the specified format
tgeDate = timestamp("16 Sep 2020 00:00") // Adjusted to the correct format

// Calculate days since TGE
daysSinceTGE = math.floor((time - tgeDate) / 86400000)
// Convert days to months using a more precise month length (365.25/12)
monthsSinceTGE = math.floor(daysSinceTGE / 30.44)

// Calculating circulating supply based on token unlock schedule
teamReleased = initialTeam + (initialTeam * math.min(monthsSinceTGE, 47) * 2.08 / 100)
investorsReleased = initialInvestors + (initialInvestors * math.min(monthsSinceTGE, 47) * 2.08 / 100)
advisorsReleased = initialAdvisors + (initialAdvisors * math.min(monthsSinceTGE, 47) * 2.08 / 100)
communityReleased = communityTokens * (monthsSinceTGE > 612 ? 1 : 0)  // 51 years = 612 months
currentSupply = teamReleased + investorsReleased + advisorsReleased + communityReleased + untracked

// Stock to Flow calculation
s2fCurrent = totalSupply / currentSupply

// Plotting Stock to Flow value with different adjustments to simulate a "rainbow"
s2fBase = plot(s2fCurrent, title="S2F Base", color=color.blue)
s2fHigh = plot(s2fCurrent * 1.05, title="S2F High", color=color.red)  // Simulated higher S2F range
s2fLow = plot(s2fCurrent * 0.95, title="S2F Low", color=color.green)  // Simulated lower S2F range

// Fill between plots to create a rainbow effect
fill(s2fBase, s2fHigh, color=color.new(color.red, 90), title="High Fill")
fill(s2fBase, s2fLow, color=color.new(color.green, 90), title="Low Fill")
