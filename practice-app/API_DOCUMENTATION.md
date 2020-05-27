
# BASE URL: 13.58.21.212:5001

## Filtering Events
Filters by radius and place and returns events. If no filter is defined, it returns 30 events.

**URL :** `api/events/filter`<br>
**METHOD :** `GET`<br>
**AUTHORIZATION :** `-`<br>
**PARAMETERS :** `?radius={radius distance}km&place={place  name}`
### RESPONSE
Returned JSON Object from request `BASE_URL/api/events/filter?radius=1km&place=Seattle`

    {"count":10,"conferences":[{"title":"Seattle Job Fair June 25 - Holiday Inn Seattle Downtown","description":"Looking for a job in Seattle? If you are this event is a must attend. Meet with top hiring companies in Seattle.","labels":["career","education","expo"],"start":"2020-06-25T18:00:00Z","end":"2020-06-25T21:00:00Z","country":"US","state":"active"},{"title":"CleanTech Innovation Showcase","description":"","labels":["expo","industrial","technology"],"start":"2020-06-24T14:15:00Z","end":"2020-06-25T01:00:00Z","country":"US","state":"active","address":{"name":"Bell Harbor International Conference Center","type":"venue","entity_id":"Peq3vMhQvLFRRGKRNRCD23","formatted_address":"2211 Alaskan Way\nSeattle, WA 98121\nUnited States of America"}},{"title":"Pri-Med Regional Conference Seattle","description":"","labels":["conference","health","medical"],"start":"2020-06-22T16:00:00Z","end":"2020-06-24T01:00:00Z","country":"US","state":"active","address":{"name":"Washington State Convention Center","type":"venue","entity_id":"UR2pJC7ScLLUxLPsaXYkEC","formatted_address":"705 Pike Street\nSeattle, WA 98101\nUnited States of America"}},{"title":"Self Defense for Women","description":"In this self-defense seminar for women you'll learn the most important lesson: that you have choices. In a single session you'll learn about real risks, assailant tricks, crucial targets and how to create an impact, and releases from the most common grabs. You will learn about how to recognize when someone is looking at you like a victim, and how to prevent attack -- but, if attacked, how to fight back and escape. Joanne Factor has been teaching safety and self-defense for over 19 years. As owner and instructor at Strategic Living Personal Safety and Self-Defense Training, she's taught ages 5 to 75, students and sorority sisters, homeless women and business executives, and everyone in between. She is also a volunteer advocate for DAWN, an agency in South King County providing services to domestic violence survivors. Joanne's expertise has been featured on KIRO Channel 7 TV, Q13's Washington's Most Wanted, KUOW 94.9 FM, and The Seattle Times Magazine. Originally from Brooklyn, New York, Joanne holds a BA from Cornell University, a black belt in karate, and was named Seattle's Best Feminist Butt-Kicker in 2007 by the Seattle Weekly. She is author of the forthcoming book Self-Defense 101: What Every Woman Absolutely, Positively Needs to Know for Her Own Safety. Please read our privacy, refund/rescheduling, and financial assistance policies before registering (https://www.StrategicLiving.org/privacy.php). www.StrategicLiving.org/privacy.php\n\nThank you for registering for Self-Defense Seminar for Women on Sunday, May 15. We will begin at 1:00 and end by 6:00 pm. Location is 1426 South Jackson Street, 3rd floor, Seattle WA 98144 (studio of the Feminist Karate Union). You can get directions via Google Maps, and even see a photo of the front of the building. (https://www.google.com/maps/place/1426+S+Jackson+St,+Seattle,+WA+98144/@47.5995118,-122.3149525,17z/data=!3m1!4b1!4m2!3m1!1s0x54906ac00ad8a149:0x837cd9ae00984812) Wear comfortable workout-style clothing. Because the floor is matted, we ask that no outdoor shoes be worn in the training space (bare feet or socks are fine). Bring water (or other preferred beverage) and a snack or light lunch. If you could print out and sign the Class Participation Agreement (found at this link http://www.strategicliving.org/downloads/ClassParticipAgmt.pdf) and bring it with you, that would be awesome and help ensure we start on time. Each participant should have her own form, and a parent does need to sign for anyone under the age of 18. If you cant print the form, I will have some on hand. At the beginning of class I will ask you to introduce yourselves (first name only OK), share one major concern you'd addressed in this class, and tell us how you found this particular class (my website, from a friend, the Seattle Times article, etc.). Thanks to all of you who already noted your specific concerns when registering online, that is very helpful. If there are any topics you'd like to ensure we cover, please email me. My cellphone, in case you need directions or are running late, is 206-920-8882. Please note, though, that I will be turning my phone's ringer off when class begins. I look forward to working with you on Sunday! Sincerely, Joanne","labels":["community","education"],"start":"2020-06-21T17:30:00Z","end":"2020-06-21T22:30:00Z","country":"US","state":"active","address":{"name":"Feminist Karate Union","type":"venue","entity_id":"334Hht8bmYCCBFNpXNE4rZB","formatted_address":"920 S Holgate St\nSeattle, WA 98134\nUnited States of America"}},{"title":"Zak World of Facades Seattle","description":"","labels":["conference","construction"],"start":"2020-06-18T16:00:00Z","end":"2020-06-19T01:00:00Z","country":"US","state":"active","address":{"name":"Grand Hyatt Seattle","type":"venue","entity_id":"QrQniqC2vLfLnsbZzfmieG","formatted_address":"721 Pine St\nDowntown\nSeattle, WA 98101"}},{"title":"Children's Literature Association Conference","description":"","labels":["conference","education"],"start":"2020-06-18T16:00:00Z","end":"2020-06-21T01:00:00Z","country":"US","state":"active","address":{"name":"Hyatt Regency Bellevue on Seattle's Eastside","type":"venue","entity_id":"398nS2EAKy5PWfU2rDjDyeh","formatted_address":"900 Bellevue Way Northeast\nBellevue, WA 98004\nUnited States of America"}},{"title":"Community Economic Development Committee","description":"Council Chambers\n600 Fourth Ave., Floor 2\nSeattle, WA 98124\nTuesday, June 16, 2020, 2pm\n\nVenue Location: City Hall, Council Chamber\nCity Council Meeting Type: Community Economic Development Committee\nEvent Types: City Council Meeting\nAgendas: Agendas\nCommittee Chair: Tammy J. Morales, Tammy.Morales@seattle.gov, 206-684-8802\nCouncilmembers: Lisa Herbold, Debora Juarez, Andrew J. Lewis, Tammy J. Morales, Alex Pedersen, Kshama Sawant\nNeighborhoods: Downtown Commercial Core\nAudience: Adults, All\nAdditional Information: Visiting City Hall\nMore info: www.seattle.gov…","labels":["conference","politics"],"start":"2020-06-16T21:00:00Z","end":"2020-06-16T21:00:00Z","country":"US","state":"active","address":{"name":"Council Chambers","type":"venue","entity_id":"ST9C7L5ZYKk57XdrGxwTYm","formatted_address":"2200 Alaskan Way\nSeattle, WA 98121\nUnited States of America"}},{"title":"Finance and Housing Committee","description":"Council Chambers\n600 Fourth Ave., Floor 2\nSeattle, WA 98124\nTuesday, June 16, 2020, 9:30am\n\nVenue Location: City Hall, Council Chamber\nCity Council Meeting Type: Finance and Housing Committee\nEvent Types: City Council Meeting\nAgendas: Agendas\nCommittee Chair: Teresa Mosqueda, Teresa.Mosqueda@seattle.gov, 206-684-8808\nCouncilmembers: Lorena González, Lisa Herbold, Andrew J. Lewis, Tammy J. Morales, Dan Strauss\nNeighborhoods: Downtown Commercial Core\nAudience: Adults, All\nAdditional Information: Visiting City Hall\nMore info: www.seattle.gov…","labels":["conference","politics"],"start":"2020-06-16T16:30:00Z","end":"2020-06-16T16:30:00Z","country":"US","state":"active","address":{"name":"Council Chambers","type":"venue","entity_id":"ST9C7L5ZYKk57XdrGxwTYm","formatted_address":"2200 Alaskan Way\nSeattle, WA 98121\nUnited States of America"}},{"title":"International Conference on Drug Drug Interactions","description":"","labels":["conference","health","medical"],"start":"2020-06-16T16:00:00Z","end":"2020-06-19T01:00:00Z","country":"US","state":"active","address":{"name":"University of Washington - Seattle Campus","type":"venue","entity_id":"8yEn6NpmBAifff8FBfhDDu","formatted_address":"Seattle, WA 98195\nUnited States of America"}},{"title":"CVPR Conference","description":"","labels":["conference","education"],"start":"2020-06-16T16:00:00Z","end":"2020-06-21T01:00:00Z","country":"US","state":"active","address":{"name":"Washington State Convention Center","type":"venue","entity_id":"UR2pJC7ScLLUxLPsaXYkEC","formatted_address":"705 Pike Street\nSeattle, WA 98101\nUnited States of America"}}]}
