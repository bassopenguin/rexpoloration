# rexpoloration
Exploration of R capabilities and limitations

## Purpose
- Understand R language
- Practice git skills
- Understand capabilities and limitations of tools

### Code Function
- Import data in CSV format
  - Format of Google Finance Historical Data Spreadsheet Download is interpreted correctly
  - NOTE: Other formats are not tested
- Create three box plots based on three configured periods
  - Configurable jitter plot overlay for each box plot
- Draw three horizontal lines denoting various price points
  - Green: Current Price
  - Blue: Original Cost Basis
    - Not displayed if original shares was configured <= 0
  - Red: New Cost Basis
    - Not displayed if current shares was configured <= 0
    - Computed by averaging original cost basis with new shares purchased at current price
- Axis labels show period and median price for box plot
- Print Median High and Low prices for Short and Long periods