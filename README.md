# InformaSinn

This is the source code of _InformaSinn_, a simple website that receives a bunch of data and returns the appropriate information. Made with ❤️ and ⚡️powered by [huggingface.co](https://huggingface.co/huihui-ai/Qwen2.5-14B-Instruct-abliterated-v2). 

## How to use
User enters a bunch of data e.g. numbers, emojis or descriptions and the program outputs appropriate information regarding this given data.

## Build

1. Checkout this Repository
2. Create an [account on huggingface](https://huggingface.co/) and an access token `read` respectively
3. Create an `.env`-file on your project root and add the line `HF_TOKEN=<your token here>`
4. Run `dart run build_runner build` to generate `env.g.dart` file.
5. Run the flutter project with `flutter run`

## Further improvements

- enable user to choose model