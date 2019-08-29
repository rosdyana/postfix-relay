import smtplib

from email.mime.multipart import MIMEMultipart
from email.mime.text import MIMEText
from email.mime.image import MIMEImage
from email.header import Header

smtp = smtplib.SMTP()
# smtp.connect('mail.rosyid.info', 25)
smtp.connect('localhost')

msgRoot = MIMEMultipart("alternative")
msgRoot['Subject'] = Header("Subject subject", "utf-8")
msgRoot['From'] = "admin@mail.rosyid.info"
msgRoot['To'] = "rosdyana.kusuma@gmail.com"
text = MIMEText(open('template.txt', 'r').read(), "plain", "utf-8")
msgRoot.attach(text)
html = MIMEText(open('template.html', 'r').read(), "html", "utf-8")
msgRoot.attach(html)
smtp.sendmail("admin@mail.rosyid.info", "rosdyana.kusuma@gmail.com", msgRoot.as_string())