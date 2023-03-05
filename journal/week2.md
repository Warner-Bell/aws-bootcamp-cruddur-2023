# Week 2 — Distributed Tracing

## Technical Tasks
### Instrument our backend flask application to use Open Telemetry (OTEL) with Honeycomb.io as the provider
![image](https://user-images.githubusercontent.com/100949697/222969498-9c155507-aa20-4020-b4e5-0a36ee35e633.png)
![image](https://user-images.githubusercontent.com/100949697/222969633-ed62cb78-3a2a-4cd9-84a4-1889fc898df6.png)
![image](https://user-images.githubusercontent.com/100949697/222969672-5d7b6623-d743-4071-bc36-919c0cd0e49e.png)
![image](https://user-images.githubusercontent.com/100949697/222969704-e0fd93cb-a1ae-4fb4-bbf7-323a1aa63b7e.png)
![image](https://user-images.githubusercontent.com/100949697/222969835-45fd0d8a-8ff2-4d60-b804-866bd2ecc25c.png)

### Run queries to explore traces within Honeycomb.io
![image](https://user-images.githubusercontent.com/100949697/222969984-ccdd3b31-d6ac-45d1-9db4-307003fb90a1.png)
![image](https://user-images.githubusercontent.com/100949697/222970045-0bcd991e-fb1d-40e9-8388-79cf1bdbb4cf.png)
![image](https://user-images.githubusercontent.com/100949697/222970123-459f4a3e-4323-479e-a937-23e4f0c481f7.png)
![image](https://user-images.githubusercontent.com/100949697/222970217-ef361869-3847-420f-9f37-b607e66a4535.png)

### Instrument AWS X-Ray into backend flask application
![image](https://user-images.githubusercontent.com/100949697/222970394-d80a2698-0c7f-4229-bf45-63aaab9b2353.png)
![image](https://user-images.githubusercontent.com/100949697/222970490-cf4c62e9-2e56-4b04-8f4d-ebbd7d00703f.png)
![image](https://user-images.githubusercontent.com/100949697/222970512-f2d58f0d-4601-4ff8-bca1-3ce5cf72f592.png)
![image](https://user-images.githubusercontent.com/100949697/222970554-1a21e3bb-209a-4163-bb0b-a7b9d209cad8.png)

### Configure and provision X-Ray daemon within docker-compose and send data back to X-Ray API
![image](https://user-images.githubusercontent.com/100949697/222970686-96d694a8-aab9-47f8-b6ba-8b896fc70fad.png)
![image](https://user-images.githubusercontent.com/100949697/222970732-0842cc64-6339-4fa3-9433-37e1ce1b1afc.png)

### Observe X-Ray traces within the AWS Console
![image](https://user-images.githubusercontent.com/100949697/222970622-024822a8-cd58-41ba-8abf-47769801f46a.png)
![image](https://user-images.githubusercontent.com/100949697/222970639-d3ad355e-d1c4-4bd5-af9b-06033c35ac7d.png)

### Integrate Rollbar for Error Logging

### Trigger an error an observe an error with Rollbar
### Install WatchTower and write a custom logger to send application log data to CloudWatch Log group
![image](https://user-images.githubusercontent.com/100949697/222971120-a89f85c5-2816-4455-aaf1-e579be7288c5.png)
![image](https://user-images.githubusercontent.com/100949697/222971181-cfdccfbb-8bc5-4744-8bd1-6d0814b48f61.png)
![image](https://user-images.githubusercontent.com/100949697/222971233-96efe77d-98fd-46b5-ac5c-6d9b03e31ba1.png)
![image](https://user-images.githubusercontent.com/100949697/222971266-6a0cc9a3-601b-4eb3-8a7d-a77c2198dcd4.png)


## Homework Challenges 

### Instrument Honeycomb for the frontend-application to observe network latency between frontend and backend[HARD]
### Add custom instrumentation to Honeycomb to add more attributes eg. UserId, Add a custom span
### Run custom queries in Honeycomb and save them later eg. Latency by UserID, Recent Traces
