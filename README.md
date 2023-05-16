# dart_in_lambda

- I want to construct a way to work in dart and deploy the programs to 
  AWS Lambda. 

- I see that there aren't great ways to quickly iterate and test the dart code, since
  programs need to run in Linux environments. 

- I will use this project to come up with interesting ways to make dart applications that will
  primarily run in the AWS Lambda environment. 


 # System Requirements
 1. Docker
 2. AWS CLI 
 3. AWS SAM (This may be temporary). 
 4. Dart


 # Project Layout
 ── LICENSE.md

├── README.md

├── compile.Dockerfile

├── compile_deploy.sh

├── docker-compose.yml

├── env.json

├── events

│   ├── apigateway_get_event.json

│   └── test_event.json

├── lib

│   └── api_gateway

│       ├── handler.dart

│       ├── local_api_only.dart

│       └── main.dart

├── local.Dockerfile - This is used for local development

├── local_test.sh

├── pubspec.yaml

├── samconfig.toml

├── template.yaml

├── test

│   └── handler_test.dart

└── test.sh

# Dart Set-up
 - `dart pub get` to get all the dependcies. 
  - In the samconfig.toml file you'll need to add your AWS profile name there.  This is the profile in your aws key and secret on your local machine for your AWS account. Right now its set to my own.

# Scripts
- `compile_deploy.sh` will use a docker container to compile our code for an arm64 environment and then deploy it using AWS SAM. 
- `local_test.sh` compiles and locally invokes the lambda function containing our code. 

# Local Development Workflow
1. Yes, test, test, test.  `dart test` runs the tests in the `./test` folder.  
   Here we emulate the ApiGateway environment by building the requests and passing the events into the handler.

2. Also, if you want to run a local server, it's not a perfect representation, but its better than trying
   to figure out a perfect representation, run the docker container with docker compose. 
   - `docker-compose up` 
   - The docker compose container configuration also implements a local AWS DynamoDB for local testing. 

   This starts the server at http://127.0.0.1:8080.  
   NOTE: I recommend you don't change this file, as its just a script needed for local development/debugging.

## TODO 
- I need a way implement https testing.
- So far, I enjoy my modificiations on how to manage and work on dart programs in the lambda environment. 
I am making this to be a repeatable and re-useable base project for building applications in the serverless environment. 

- Create an example for handling S3 events. 
- Create an example for handling SQS events.
