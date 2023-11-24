# Newa Api Implementation with Flutter

I have created the application according the rules provided by you.

1. I have stored apikey in environment variables and not hardcoded it using __dotenv__.
2. I have implemented search and filtering for both everything api and top-headlines api
3. I have added bookmark section where users can store their favourite story in bookmark section. I have used __sharedPreferences__ for storage purposes.
4. I have implemented the __webview__ so that users can open the actual article inside the app itself.
5. I have used __provider state management__.
6. **Error handling** is done swiftly and in user-friendly way

##Explanation

1. The first screen is the home screen where you will see a bookmark icon which takes you to bookmark screen then there is a search bar from which you can filter and search from everythin API. You can filter with sort-by from date and to-date.
2. Next there is view more button in row with top headlines title on clicking that button you will go to top headlines API filtering and searching screen.
3. On each story there is bookmark on clicking bookmark you can add/remove bookmark.
4. __IMPORTANT__There is add service button along with the service name(only for those services which have an id). You can add your favorite service. If you click on service name you will be taken to headline api search and filter screen where the relevant filters will be automatically applied.
5. If you click on any post you can se more details and a read more which will take you to the actual article.
6. In the headline api screen we have filter and search. You can filter according to country and category.

##IMPLEMNTATION
Implementation
<p float='left>![Alt text](<Simulator Screenshot - iPhone 15 Pro Max - 2023-11-24 at 18.45.04.png>) ![Alt text](<Simulator Screenshot - iPhone 15 Pro Max - 2023-11-24 at 16.50.59-1.png>) ![Alt text](<Simulator Screenshot - iPhone 15 Pro Max - 2023-11-24 at 16.51.10-1.png>) ![Alt text](<Simulator Screenshot - iPhone 15 Pro Max - 2023-11-24 at 16.51.18-1.png>) ![Alt text](<Simulator Screenshot - iPhone 15 Pro Max - 2023-11-24 at 16.51.52-1.png>) ![Alt text](<Simulator Screenshot - iPhone 15 Pro Max - 2023-11-24 at 16.52.23-1.png>) ![Alt text](<Simulator Screenshot - iPhone 15 Pro Max - 2023-11-24 at 16.52.30-1.png>) ![Alt text](<Simulator Screenshot - iPhone 15 Pro Max - 2023-11-24 at 18.36.43.png>)></p>
