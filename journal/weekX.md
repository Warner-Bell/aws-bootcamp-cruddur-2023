# Week x — Cleanup

# Week-X 😱 😨 💪 🚀

## Table of Contents

- **[Sync tool for static website hosting](#sync-tool-for-static-website-hosting)**
- **[Required Homework](#required-homework)**
- **[Reconnect DB and Post Confirmation](#reconnect-db-and-post-confirmation)**
- **[Use CORS for Service](#use-cors-for-service)**
- **[CICD Pipeline and Create Activity](#cicd-pipeline-and-create-activity)**
- **[Refactor JWT to use a decorator](#refactor-jwt-to-use-a-decorator)**
- **[Refactor App.py](#refactor-apppy)**
- **[Refactor Flask Routes](#refactor-flask-routes)**
- **[Replies](#replies)**
- **[Refactor Error Handling and Fetch Requests](#refactor-error-handling-and-fetch-requests)**
- **[Activity Show Page](#activity-show-page)**
- **[Cleanup](#cleanup)**
- **[Cleanup2](#cleanup2)**
- **[Conclusion](#conclusion) 😃**

# Technical Tasks


## Required Homework

After a complete teardown and redeploy of all resources related to my app back up to CloudFormation. The real work began!

## Sync tool for static website hosting

We began week x with the intent to get our application working again after refactoring with cloudformation.
The idea was to compile the frontend, and drag it all over to our website bucket.
We created a file called static-build consisting of paths and variables we needed for npm run build.
After running the file, we get a build directory that we zip and download, extract and upload the contents into our domain bucket.
We then needed a way to synchronize changes to that data from gitpod to aws, Andrew had previously created a tool called (aws website s3 sync)...that we would use to handle that function.
We looked at GitHub actions but found it not worth the time so moved on.

## Reconnect DB and Post Confirmation
Next, we needed to reconnect the database and work on post confirmation lambda
The debug-mode was showing up when we went to activities/home that was not desired so we rebuilt, registered and pushed a new backend image, we found the service role names had a mismatch and corrected it.
We decided to try to delete and redeploy the service stack and we found issues with dependencies cross-reference stacks, decided to remove those connections.
Originally, the tasks kept failing, we had to go back to dev, and do debugging. We setup prod access locally, fix prod version of flask, added SG rules, and fixed update sg rule and updated envars.
We then logged into the database, ran schema load and attempted to load schema and migrations with an override (CONNECTION_URL=$PROD_CONNECTION_URL ./bin/db/migrate). 46:03
The next step was to delete all the cognito users and re-sign up, but first we added custom error reporting to the frontend cfn template and re-deployed.
Then we found out the vpc and sec group needed updating on the post-conf-lambda, so we set that and added the COGNITOPOST rule to the SG. We then create the user. 1:04:56
The next step was attempt a CRUD, we did and got back a 500 cors error, so we went to look at rollbar logs and cleared them for a fresh set. We retried the crud and Andrew found no rollbar logs so we went to ECS-Backendflask and also found no logs. So we went to cloudwatch and found (AttributeError: 'NotNullViolation' object has no attribute 'pgerror').
Wasn’t sure what the error was, decided to test locally, so we seeded the data by running ./bin/db/setup. Created a crud and It worked with no issues.
![image](https://github.com/Warner-Bell/aws-bootcamp-cruddur-2023/assets/100949697/6dc1637f-5d50-4a47-850a-d337b28983c9)

We then connected to the prod db and ran select * from Users; 
Originally, Andrew got back nothing when running the command, so we went back to Lambda and looked at the logs, Andrew got the (function takes 2 args but got 5 error). And decided to refactor the query in the lambda code to the following.
![image](https://github.com/Warner-Bell/aws-bootcamp-cruddur-2023/assets/100949697/22fc227e-1052-4aff-bef1-d86113f85784)

We then verified the error was gone in cloudwatch, it was. We then verified the new user was added to the table, it was.
![image](https://github.com/Warner-Bell/aws-bootcamp-cruddur-2023/assets/100949697/1ff09a2d-13f5-453d-9ffd-60db3fe57dec)
![image](https://github.com/Warner-Bell/aws-bootcamp-cruddur-2023/assets/100949697/f0986f18-c27e-40fa-80c5-639b5bd4f0d6)

Next was to sign in and try a new crud. That work out just fine (Test CRUD after PROD DB connected and Lambda refactor)
![image](https://github.com/Warner-Bell/aws-bootcamp-cruddur-2023/assets/100949697/fc86bed8-197a-4c6f-b8ea-32870a93adf3)


## Use CORS for Service
First we updated frontend and backend URLs, then redeployed the service we had to turn on parameters to avoid an update error. 
Once the stack deployed we found DREADED CORS issues..we tried putting the protocol in front of the URLs and it worked.
![image](https://github.com/Warner-Bell/aws-bootcamp-cruddur-2023/assets/100949697/9a9b8908-9287-41d6-a82c-dadcf8b708a5)


## CICD Pipeline and Create Activity

This is where I found out my Profile Page was broken, after clicking profile I got the following;
![image](https://github.com/Warner-Bell/aws-bootcamp-cruddur-2023/assets/100949697/69b0d9be-78be-4b7c-9b99-e82261a17ab8)

I went back to HOME page andretested the CRUD to see if it still worked , it did.
![image](https://github.com/Warner-Bell/aws-bootcamp-cruddur-2023/assets/100949697/1d13e9f0-b3e3-48ac-b702-38b46aaf753d)

The issue did not happen to Andrew as he went through the video, so I was certainly at a loss, I fumbled around for a while then I thought of discord and logged in hoping for a resolution. 
Found this post by Rauul, with an answer from Felix, tried it, and it worked, whew!
![image](https://github.com/Warner-Bell/aws-bootcamp-cruddur-2023/assets/100949697/2177edb7-5830-452f-b055-f0b679d10d39)

The next thing to do was create another user, so that is what I did. In addition, try a new CRUD, it worked.
![image](https://github.com/Warner-Bell/aws-bootcamp-cruddur-2023/assets/100949697/e138edbd-2845-45c4-a30b-b7059d2c4ccb)

Some app.py refactoring was necessary to make AltBELL’s CRUD display the correct name.
We set the db back to local in the env. And composed dwn/up, logged in as Alt and tried CRUD, it worked.
![image](https://github.com/Warner-Bell/aws-bootcamp-cruddur-2023/assets/100949697/7b7f2d68-c9c3-4712-83c7-d1d42e432b17)

Then we performed a pull request to deploy the changes and see if the cicd pipeline would complete. It didn’t work for Andrew right away because his repo name was incomplete in his config.toml. 
We then learned we needed to add the BatchGetBuilds permission to the codebuild cfn. 
We also needed to add a bucket policy into the codebuild cfn for the artifacts bucket and reference the buildspec path. After which Alt Andrew was able to post CRUD.


## Refactor JWT to use a decorator

Working in local db app, we started by adding a close event to the reply form. Tested that we could now close the reply for and it worked.
![image](https://github.com/Warner-Bell/aws-bootcamp-cruddur-2023/assets/100949697/ec6277c8-298d-48d1-941e-6ef29b8869fd)
![image](https://github.com/Warner-Bell/aws-bootcamp-cruddur-2023/assets/100949697/b33faedc-cabc-4a61-96a9-6444d91edd1d)

We then added (def decorated_function), and env vars to jwt_token.py. then began refactoring app.py.

## Refactor App.py

This session we undertook a heavy refactor of app.py.
![image](https://github.com/Warner-Bell/aws-bootcamp-cruddur-2023/assets/100949697/41181784-b41b-499e-b454-1b6915c28f70)


## Refactor Flask Routes

This session we undertook a heavy refactor of routes.
![image](https://github.com/Warner-Bell/aws-bootcamp-cruddur-2023/assets/100949697/cd4c9182-cdb8-4dc3-84be-faab96083e10)

## Replies

In this section we worked on fixing and refactoring replies, we found the migrations needed updating.

## Refactor Error Handling and Fetch Requests

Next, we began doing some error handling and added some placeholder data (Nothing to see here yet!).
![image](https://github.com/Warner-Bell/aws-bootcamp-cruddur-2023/assets/100949697/9447d2a2-a711-4ada-b0a4-1c225f580804)

We added errors to multiple forms and tested.
![image](https://github.com/Warner-Bell/aws-bootcamp-cruddur-2023/assets/100949697/1c65e3ae-84d9-4270-94f6-1bd4c70bab30)


## Activity Show Page

We started this section with an inability to complete a reply, the reply_to_activity_uuid | integer, was supposed to be getting switched to a uuid so some debugging was in order.
An adjustment to the migrations file was needed.
![image](https://github.com/Warner-Bell/aws-bootcamp-cruddur-2023/assets/100949697/264dda0d-208b-44a0-b724-a4092edf3bfe)

Next, we needed to tackle reply counts, but were sidetracked with links, so we worked on that for display name. We created activity show pages for .js and .css and updated other pages to fix rendering.

## Cleanup

Here we began cleanup ops, we first added some more mock data and updated times in the seed data.
We wanted to put in a back button, so we went to ActivityShowPage and updated code.
![image](https://github.com/Warner-Bell/aws-bootcamp-cruddur-2023/assets/100949697/5e149292-56a4-4045-9ebe-52f5a776e2cd)

### Had a laugh when Andrew got his domains mixed up, I had been doing it all day...lol.

Had to fix up .css for the Activities, did some styling and left the rest.


## Cleanup2

Here it was time to ro1l the previous work into production. First migrations needed to be ran.
Then it was pull request, to start cicd for rollout, and then synchronize the frontend.
![image](https://github.com/Warner-Bell/aws-bootcamp-cruddur-2023/assets/100949697/6324b150-a303-4ac6-ad88-8cafa949a1b4)

There were some sync issues that needed addressing on the Message Form and Groups pages, which we addressed.
We needed a new env var for the ddb message table, so we updated ddb.py and backend env vars.
Next, on new message page when sending a message we get a 500 error upon post attempt, along with the 403 error we have already had.
![image](https://github.com/Warner-Bell/aws-bootcamp-cruddur-2023/assets/100949697/d50dfd96-aa5d-4c62-ae3e-c1c7d1257e9b)

So, I go check rollbar logs and get the following;
![image](https://github.com/Warner-Bell/aws-bootcamp-cruddur-2023/assets/100949697/e4cd1441-eeca-4fa9-be97-bb51b96c4696)

Had no idea what it meant, but it looked like it did not like my users credentials, so I changed them and tried again with no joy. My error was different than the one Andrew got, but was still a 500 so I continued. 
Next, we created a MachineUser to grant access to our app, hoping it would solve for x.
Created access keys, went to parameter store and swapped them out for the other values.
We then released change on the pipeline.
Once the change was deployed, went back to the app and clicked messages, still could not see any, inspected the page found the 500 error was gone! yaaaaay!!!!, however the 403 error remained.
![image](https://github.com/Warner-Bell/aws-bootcamp-cruddur-2023/assets/100949697/ae8b1672-ecdb-4aab-bdf7-a6de3b039eac)
![image](https://github.com/Warner-Bell/aws-bootcamp-cruddur-2023/assets/100949697/18aabfe4-80c2-4583-a1ff-37a1b8f24438)

Upon closer look, turns out the 403 was just superficial on a .jpg, so had to go try the messaging, and it WOOOOORKKKED!
![image](https://github.com/Warner-Bell/aws-bootcamp-cruddur-2023/assets/100949697/8d215b51-4d09-40e8-a5a1-76ea136feae5)

## Conclusion

### This has been One of the most grueling weeks of I can remember! One week ago today I submitted what I figured was a decent enough version of this app, to get by with possibly gold squad (I knew red was a stretch) but I wanted to at-least finish, and it was hard!, the last month has been so busy at work and even after work, I had been struggling for weeks to keep up with the boot-camp, I would run into an issue obsess on it for days, hit a wall, have to put it down for a while, I can admit I entertained the thought of quitting briefly, but I never saw myself giving up, I was going to finish what I started, so worked on it till I thought I was outta of time and sent it in for judgment😨..Lol, the thing was so broke; Andrew messaged me and said the validator would not even run on it😱 Noooooo...lmao! You got to be Bull$h*tn lhh. He gave me some great tips and told me I still had time to at-least get it respectable for gold, to be honest I was a little embarrassed, I said to myself na I aint goin out like that, and vowed to fix it..So, every free second of my life for the past 7 days has been Mission Impossible: 💪Flex under Pressure.

## I can not tell you how good it feels to be looking at the Picture below, I pulled off, right down on the wire!
![image](https://github.com/Warner-Bell/aws-bootcamp-cruddur-2023/assets/100949697/eeadf53e-79c0-4854-8b1f-3a3b8d297cb8)



