# **St. Louis City Crime Visualisations**

Downloaded crime offences and hate crime data from Metropolitan Police Department St. Louis City [website.](http://www.slmpd.org/Crimereports.shtml)

## **Coordinates Transformation**
Data was processed in R studio primarily to transform the coordinates from **NAD83 format (North American Datum of 1983)** to **World Geodetic System 1984 (WGS84)** as it is readable by Tableau. I used the **library rdgal in R studio.** 

First we assigned a known Coordinate Reference System to the spatial data (ESRI: 102696 for St. Louis City) and then spatially transformed the coordinates to WGS84 (EPSG: 4326).

A good read to understand more: [Overview of Coordinate Reference Systems (CRS) in R](https://www.nceas.ucsb.edu/~frazier/RSpatialGuides/OverviewCoordinateReferenceSystems.pdf)

## **Other Preprocessing**
UCR Codes and Neighborhood Names / Population was simply joined in Excel using the Vlookup function for ease.

## **Tableau**
To replicate the Tableau visualisations in files **TABLEAU.twb and Interactive Dashboard.twb**, simply link the Tableau files with the **crimedata.csv** in the Data folder as it is the final preprocessed file.

To replicate the Tableau visualisations in files **TABLEAU_2.twb**, simply link the Tableau file with the **hatestat.xlsx** in the HateCrimeStats folder

The interactive dashboard can be accessed over here: [Check it out!](http://public.tableau.com/profile/raghav.mehta#!/vizhome/StLouisCrimeData/Dashboard1)

## **Infographic**
The infographic (size A3) was created using [Venngage](http://venngage.com/)
