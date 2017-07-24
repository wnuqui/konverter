# konverter

A Rails application that converts currency. This is the application I used for my Ruby talk entitled **"To Test or To Not Test a Test Code"** (Philippine Ruby Users Group / July 2017 Meetup).

## Specifications
- [x] Convert currency to another currency using Google
- [x] Save/cache conversion for the next 60 seconds
- [x] After 60 seconds, convert using the Google again

## Talk
### YouTube
[![My Ruby talk presented last Philippine Ruby Users Group July 2017 meetup](https://img.youtube.com/vi/Kwpq6IaNW2A/0.jpg)](https://www.youtube.com/watch?v=Kwpq6IaNW2A&t=110s)

### Summary
Normally, test code do not require tests. The reason mainly is that frameworks and tools are used which themselves have tests. But there are situations wherein abstraction code are implemented to assist in testing hence a test code. This kind of test code are no differrent to our production code (still a code) and needs to be tested. And if the abstraction is reusable then it can be canned as a PR for a related test framework/tool.
