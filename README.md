# AutoLogoMe
This app will attempt to retrieve a company logo when provided with a domain name. Once the logo has been retrieved, the image for customer or vendor in question will be automatically updated with that logo.

## Working
The app will add an action named _Retrieve Logo_ to the Home group in the ribbon of the following pages:
- Customer List
- Customer Card
- Vendor List
- Vendor Card

This action will attempt to retrieve the logo. In order for this to work, either the customer/vendor email or home page fields must be filled with a valid address.

## Dependencies
This app uses the website https://logo.clearbit.com/ as a source for retrieving the logo. The creator of this app is not affiliated with the wonderful people who created that tool and is also not responsible for its upkeep or continued operation.

## Credits
This project was inspired by a video by the ever clever Erik Hougaard, where he demonstrates the magic behind this app.
The video link: https://www.youtube.com/watch?v=xLJnF38UAe4
