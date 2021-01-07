import sendgrid

sg = sendgrid.SendGridAPIClient(api_key="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")


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

    response = sg.client.mail.send.post(request_body=data)
    '''
    print(response.status_code)
    print(response.body)
    print(response.headers)
    '''
