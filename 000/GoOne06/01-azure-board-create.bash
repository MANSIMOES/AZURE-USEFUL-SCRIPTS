# Step 1 - Epics Creations
curl -X POST \
  https://dev.azure.com/mansimoes/GoOne06/_apis/wit/workitems/$Epic?api-version=6.0 \
  -H 'Authorization: rgr3jzpu6422cmrvz6hdo66w5lml6gjb7znvfjjmk6ibzmqwrdxa' \
  -H 'Content-Type: application/json-patch+json' \
  -d '@{C:\Users\mnova\source\gitlab\mans\AZ-BOARD\epic.json}'

# Step 2 - Stories Creations
curl -X POST \
  https://dev.azure.com/{organization}/{project}/_apis/wit/workitems/$User%20Story?api-version=6.0 \
  -H 'Authorization: Basic {Base64PAT}' \
  -H 'Content-Type: application/json-patch+json' \
  -d '@/path/to/combined_user_story_1_payload.json'

curl -X POST \
  https://dev.azure.com/{organization}/{project}/_apis/wit/workitems/$User%20Story?api-version=6.0 \
  -H 'Authorization: Basic {Base64PAT}' \
  -H 'Content-Type: application/json-patch+json' \
  -d '@/path/to/combined_user_story_2_payload.json'

curl -X POST \
  https://dev.azure.com/{organization}/{project}/_apis/wit/workitems/$User%20Story?api-version=6.0 \
  -H 'Authorization: Basic {Base64PAT}' \
  -H 'Content-Type: application/json-patch+json' \
  -d '@/path/to/combined_user_story_3_payload.json'

curl -X POST \
  https://dev.azure.com/{organization}/{project}/_apis/wit/workitems/$User%20Story?api-version=6.0 \
  -H 'Authorization: Basic {Base64PAT}' \
  -H 'Content-Type: application/json-patch+json' \
  -d '@/path/to/combined_user_story_4_payload.json'

# Step 3 - Tasks Creations
