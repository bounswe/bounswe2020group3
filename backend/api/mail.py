import sendgrid
import os

sg = sendgrid.SendGridAPIClient(api_key=os.environ.get("SENDGRID_APIKEY"))


def send_mail(name, url):
    data = {
        "from": {
            "email": "bounswe2020group3@gmail.com",
            "name": "Paper Layer"
        },
        "personalizations": [
            {
                "to": [
                    {
                        "email": "f.cansever67@gmail.com"
                    }
                ],
                "dynamic_template_data": {
                    "name": name,
                    "notification_url": url
                }
            }
        ],
        "template_id": "d-8f1578c0872a4e2680862372bd0f5bf1"
    }

    sg.client.mail.send.post(request_body=data)
