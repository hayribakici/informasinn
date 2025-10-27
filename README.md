# InformaSinn

This is the source code of _InformaSinn_ (as in **_Informa_**tion and **_Sinn_**, translated Information-Sense), a simple website that receives a bunch of data and returns the appropriate information. Made with ❤️ and ⚡️powered by [huggingface.co](https://huggingface.co/huihui-ai/Qwen2.5-14B-Instruct-abliterated-v2). 

## How to use
User enters a bunch of data e.g. numbers, emojis or descriptions and the program outputs appropriate information regarding this given data.

## Educational notes

With this tool, students are able to explore the reasoning behind data in everyday life and what information they hold.

## Build

1. Checkout this Repository
2. Create an [account on huggingface](https://huggingface.co/) and an access token `read`.
3. Create an `.env`-file on your project root and add the line `HF_TOKEN=<your token here>` and `BASE_URL=<your base url>` respectively.
4. Run `flutter run web --dart-define-from-file=.env`
5. Enjoy 🎂

## Deploy by yourself

tba.

## Further improvements

- enable user to choose model
