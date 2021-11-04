# robot-test-action

This is an example on how a Robotframework test suite can be executed via a Github Action.
In this case the Github Action API is used to trigger a run of the test suite.

The test suite will take a URL and a text string as inputs. It will then navigate to the URL and verify that this text string can be found.

## Start a test run via Github Actions API

```
curl --location --request POST 'https://api.github.com/repos/nilsty/robot-test-action/actions/workflows/14916260/dispatches' \
--header 'Authorization: ...' \
--header 'Content-Type: application/json' \
--data-raw '{
    "ref": "main",
    "inputs": {
        "url": "https://robotframework.org/",
        "text": "Robot Framework"
    }
}'
```

The URL and text string are definded as input parameters for the github actions workflow.
[The Authorization for this request can be done via Basic Auth. The user is the Github user name and the password needs to be a Personal Access Token.](https://docs.github.com/en/rest/overview/other-authentication-methods#via-oauth-and-personal-access-tokens)
