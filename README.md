# Business intelligence app in QlikSense

Business Intelligence app built in Qlik Sense, based on the dataset from AirBnB. The goal is to explore and visualize key patterns in Airbnb listings across major European cities using different data visualization techniques.

![Alt text](https://github.com/roxanatdg/QlikSense-app/blob/main/Pics/qliksense-app.png)


**📊 Enhanced Data Categorization for Deeper Insights**

To uncover trends more effectively, I implemented custom bucketing logic across multiple variables using Qlik Sense's `IntervalMatch` feature. These buckets segment continuous metrics into intuitive categories, improving visual analysis and filtering capabilities.

* **CityCenterRange**: Classifies listings by proximity to the city center (e.g., Central, Inner Ring, Outer Ring), enhancing location-based pricing insights.
* **MetroRange**: Clusters listings by distance to the nearest metro station, helping assess accessibility-driven value.
* **RestaurantRange & AttractionRange**: Groups listings by nearby restaurant and attraction density, revealing patterns tied to amenity-rich areas.
* **SatisfactionRange**: Segments properties based on guest satisfaction scores, enabling quality-based comparisons.

This structured binning approach makes it easier to visualize and analyze Airbnb listings in a user-friendly, non-technical way. 📊 View the full Qlik Sense script here: [airbnb_disertatie.qvs](./airbnb_disertatie.qvs)








