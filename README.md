<h1 align="center">
  InformaSinn <br />
  <i>Information</i> and <i>Sinn</i>, translated Information-Sense
</h1>

Source code of an educational program, where students are able to explore the relationship of _data_ and _information_.

## How to use
User enters a bunch of data e.g. numbers, emojis or descriptions and the program outputs appropriate information regarding this given data.

## Educational notes

With this tool, students are able to explore the relationship between everyday data (e.g. 👋-emoji) and the information they are holding (e.g. 👋 means greeting).

## Build

1. Checkout this Repository
2. Create an [account on huggingface](https://huggingface.co/) and an access token `read`.
3. Create an `.env`-file on your project root and add the line `HF_TOKEN=<your token here>` and `BASE_URL=<your base url>` respectively (don't forget to add it tho your `.gitignore` file).
4. Run `flutter run web --dart-define-from-file=.env`
5. Enjoy 🎂

## Deploy by yourself

tba.

## Further improvements

- enable user to choose model
- enable user to change language of interface
