# cf-dynip

Bash script that get the current public dynamic IP and updates a CF DNS A-record.

Requires setting a `.env` file in the script folder with the A-record identification and the Zone ID available in the CF dashboard. Also needs a CF API token able to write DNS settings:

```bash
# CF API token
API_TOKEN=

# CF Zone ID, get it on the domain dashboard
ZONE_ID=

# DNS record
RECORD_ID=
RECORD_NAME=
```
