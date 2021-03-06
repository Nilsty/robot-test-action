# robot-test-action

This is an example on how a Robotframework test suite can be executed via a Github Action.
In this case the Github Action API is used to trigger a run of the test suite.

The test suite will take a URL and a text string as inputs. It will then navigate to the URL and verify that this text string can be found.

## Start a test run via Github Actions API

```
curl --request POST 'https://api.github.com/repos/nilsty/robot-test-action/actions/workflows/14916260/dispatches' \
--header 'Authorization: ...' \
--header 'Content-Type: application/json' \
--data-raw '{
    "ref": "main",
    "inputs": {
        "run-id": "your workflow run identifier"
        "url": "https://robotframework.org/",
        "text": "Robot Framework"
    }
}'
```

The URL and text string are definded as input parameters for the github actions workflow.
[The Authorization for this request can be done via Basic Auth. The user is the Github user name and the password needs to be a Personal Access Token.](https://docs.github.com/en/rest/overview/other-authentication-methods#via-oauth-and-personal-access-tokens)

## Verify that you fetch the right test run

Based on the submitted `run-id` in your POST request to start the test run, you can identify the workflow run in Github.

The concept of the workflow run identifier is explained [here](https://stackoverflow.com/questions/69479400/get-run-id-after-triggering-a-github-workflow-dispatch-event).

## Check the test run status

You can check the status of the test run by querying the `/actions/runs` endpoint. Here is an example:

```
curl --request GET 'https://api.github.com/repos/nilsty/robot-test-action/actions/runs' | jq '.workflow_runs[0].status'
```

Output:

```
"completed"
```

## Check if a test run was successful or has failed

```
curl --request GET 'https://api.github.com/repos/nilsty/robot-test-action/actions/runs' | jq '.workflow_runs[0].conclusion'
```

Output:

```
"success" / "failure"
```

## Retrieve the test report

First you need to get the workflow id of your actions run.

```
WORKFLOW_ID=$(curl --request GET 'https://api.github.com/repos/nilsty/robot-test-action/actions/runs' | jq '.workflow_runs[0].id')
```

With the workflow id you will be able to get the artifact download url.

```
curl --request GET 'https://api.github.com/repos/nilsty/robot-test-action/actions/runs/'${WORKFLOW_ID}'/artifacts' | jq '.artifacts[0].archive_download_url'
```

From this URL you will be able to download the zipped test report.

## Further information

If you need to customize any of the Github Actions API requests, please refer to their [REST API reference](https://docs.github.com/en/rest/reference/actions).

This setup is using the github action [joonvena/robotframework-docker-action@v1.0](https://github.com/joonvena/robotframework-docker-action). Which is utelizing the [ppodgorsek/docker-robot-framework docker image](https://github.com/ppodgorsek/docker-robot-framework)
