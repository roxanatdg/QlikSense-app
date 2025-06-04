# Business intelligence app in QlikSense

  Business Intelligence app built in Qlik Sense, based on the dataset from AirBnB. The goal is to explore and visualize key patterns in Airbnb listings across major European cities using different data visualization techniques.

![Alt text](https://github.com/roxanatdg/QlikSense-app/blob/main/Pics/qliksense-app.png)

**📊 Enhanced Data Categorization for Deeper Insights**

  To uncover trends more effectively, I implemented custom bucketing logic across multiple variables using Qlik Sense's `IntervalMatch` feature. These buckets segment continuous metrics into intuitive categories, improving visual analysis and filtering capabilities.

* **CityCenterRange**: Classifies listings by proximity to the city center (e.g., Central, Inner Ring, Outer Ring), enhancing location-based pricing insights.
* **MetroRange**: Clusters listings by distance to the nearest metro station, helping assess accessibility-driven value.
* **RestaurantRange & AttractionRange**: Groups listings by nearby restaurant and attraction density, revealing patterns tied to amenity-rich areas.
* **SatisfactionRange**: Segments properties based on guest satisfaction scores, enabling quality-based comparisons.

  This structured binning approach makes it easier to visualize and analyze Airbnb listings in a user-friendly, non-technical way.  Full Qlik Sense script can be read here: [airbnb_disertatie.qvs](./airbnb_disertatie.qvs)

The Report Builder section provides an interactive feature for generating custom reports based on Airbnb data. Users can select cities and apply additional filters (such as distance from the city center, proximity to the metro, capacity, etc.) to analyze key indicators. The predefined table displays metrics such as minimum price, maximum price, number of bookings, and average price.

![Alt text](https://github.com/roxanatdg/QlikSense-app/blob/main/Pics/data-schema-qlik.png)

  The data model follows a snowflake schema centered on the Listings fact table, which captures property-level metrics (price, satisfaction, location indices). It connects to dimension tables—Cities, DayType, RoomType, and FurnishingLevels—using surrogate keys for clean relational joins. 

  A separate Financials table stores annual company KPIs for high-level analysis. The schema is optimized for Qlik Sense with bucketed fields to support segmentation and drill-downs.








