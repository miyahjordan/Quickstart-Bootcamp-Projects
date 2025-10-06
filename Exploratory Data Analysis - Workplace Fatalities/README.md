<h1 align='center'>Exploratory Data Anlysis - Workplace Fatalities</h1>

### Executive Summary:
Using data that shows workplace fatalities (and injuries) by state in the year 2012, I conducted an exploratory data analysis project uses Excel. The primary goal of the project was to create a dashboard that highlights one important aspect of the data and allows the reader to intereact with other aspects of the data. To complete this goal, the visualization contains descriptive statistics, a pivot table with a slicer, and utilizes data storytelling techniques. The report answers the following questions:
  1. Which program, state or federal, has the highest rate of fatalities?
     - Federal programs have the highest rate of fatalities at a rate of 128.2 versus the 87.7 found with state programs.
  
  2. Which state with a state program has the highest number of injuries/illnesses?
     - California has the highest number of injuries/illnesses.
  
  3. What is the relationship, if any, between “Average of Years to Inspect Each Workplace Once” and “Rate of Fatalities”?
     - There is a slight positive correlation between the “Average of Years to Inspect Each Workplace Once” and “Rate of Fatalities”.
 
  4. Is there was a relationship between the average number of years it takes to do one inspection and the number of inspectors in each state?
     - The number of inspectors does not have an impact on the average amount of inspection years.
  
  5. Does the average inspection years have an impact on injury and fatality rates?
     - The amount of time it takes to inspect one workplace does have a small impact, with the longer it takes occasionally resulting in higher reported rates of injuries/illnesses and fatalities.

### Business Problem:
It's important to assess the safety of workplaces across the country. Using data from 2012, I needed to see which program has the highest rate of fatalities (state or federal), which state with a state program has the highest number of fatalities, and if there is a relationship between the average amount of years to inspect a worplace and the rate of fatalities within said workplace. On top of the questions, I wanted to know if there was a relationship between the number of inspectors in a state and the amount of time it takes to inspect a workplace, and if the avergae amount of inspection years have an impact on injury and fatality rates.

### Methodology:
Using Excel to:
1. Highlight at least one interesting aspect of the data
2. Allow a reader to interactively explore other aspects of the data

### Skills:
Exploratory data analysis, Analytics storytelling, Data analysis, Data visualization

### Results & Next Steps:
<img width="1327" height="1161" alt="canvas" src="https://github.com/user-attachments/assets/81014f3f-c55f-409f-a04a-6009ba6f04f6" />

1. I was able to determine that states with federal programs have the highest rate of fatalities at a rate of 128.2 versus the 87.7 found with state programs. Multiple things could contribute to the ratings being higher in federal programs, one of them being that there are simply more states in the federal program (29) in comparison to state programs (21).
   - Another contributing factor is that the federal states tend to have fatality ratings on a higher scale in comparison to their state counterparts.

2. As mentioned before, there are 21 states that have a state program, and out of those states California has the highest number of injuries/illnesses.
   - While it may be easier to believe workplaces in California are unsafe overall, that would be disingenuous. In 2012, California, Texas, and New York had the highest population of people in the United States with California leading by over 12 million people.
   - With this information, California is likely to have the highest injury/illness rate due to its population.
   - This is further supported when observing the same category within states in federal programs where Texas and New York are in the top three.

3. When observing the potential relationship between the “Average of Years to Inspect Each Workplace Once” and “Rate of Fatalities”, there does seem to be a slight relationship between the two.
   - I decided to utilize a combination chart utilizing both columns and lines to observe the change in time.
   - With this graph, I noticed that both graphs tend to follow the same pattern.
   - Of course, there are pieces that don’t line up exactly and there are outliers, but there is somewhat a distinct pattern between the two.

4. I constructed a scatter chart with a trendline to see if there was any correlation between the two variables. Before constructing the final graph, I expected the trendline to be negative as I assumed if a state has a higher number of inspectors, then they would have a lower average.
   - The trendline did, in fact, come back with a negative correlation, but the data itself, while mostly concentrated in one place, was relatively spread out and lacked overall direction.
   - With this information, I made the informed decision that the number of inspectors does not have an impact on the average amount of inspection years.

5. I created a stacked line chart using the fatality and injury/illness rates as well as the years in which it would take to inspect one workplace. The graph showed that both trendlines were relatively similar with illnesses/injuries being higher in volume in comparison to fatalities.
   - Aside from some outliers, it seems that the amount of time it takes to inspect one workplace does have a small impact, with the longer it takes occasionally resulting in higher reported rates of injuries/illnesses and fatalities.

While I am proud of what I accomplished, I could’ve used more advanced functions to help aid in my analysis such as VLOOKUP or XLOOKUP, I could’ve also investigated more insights on my own and I could’ve attempted to clean up my data a little better as substituting missing data with N/A did make the analysis a little harder.
