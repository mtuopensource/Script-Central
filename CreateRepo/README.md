# Script-Central
A repository of helpful scripts 

### Configure your secrets.txt
For any scripts that interface with the GitHub API, you will need to create a personal token
1. In GitHub, go to [Personal Access Tokens](https://github.com/settings/tokens) and click "Generate new token"
2. Checking the boxes for repo and admin:public_key should be good for the time being. Click "Generate token"
3. Create a file "secrets.txt"
4. Add the line Github_Token=<your_token>
5. Replace <your_token> with the token you generated in step 2. Be sure there are no spaces in your line.
