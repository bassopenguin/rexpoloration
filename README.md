# rexpoloration
Exploration of R capabilities and limitations

## Purpose
- Understand R language
- Practice git skills
- Practice Markdown skills
- Understand capabilities and limitations of tools

### Code Function
- Import data in CSV format
  - Format of Google Finance Historical Data Spreadsheet Download is interpreted correctly
  - NOTE: Other formats are not tested
- Create three box plots based on three configured periods
  - Configurable jitter plot overlay for each box plot
- Draw three horizontal lines denoting various price points
  - Current Price
  - Original Cost Basis
    - Not displayed if original shares was configured <= 0
  - New Cost Basis
    - Not displayed if current shares was configured <= 0
    - Computed by averaging original cost basis with new shares purchased at current price
- Axis labels show period and median price for box plot
- Print Median High and Low prices for Short and Long periods

### Horizontal Line Coloring Rules
- If origshares > 0
  - Draw originalcb BLACK
  - If current > 0
    - If current > originalcb
      - Draw current GREEN
    - Else If current < originalcb
      - Draw current RED
    - Else
      - DO NOT draw current (would be over top originalcb)
    - If currshares > 0
      - Draw costbasis BLUE
    - Else
      - DO NOT draw costbasis
- Else
  - If current > 0
    - Draw current GREEN


### Future enhancements
- [x] Solve Lintr problems
- [ ] Create additional optimizations
- [ ] Convert to Shiny app with interactivity
