import httplib2
import pprint
import sys

from apiclient.http import MediaFileUpload
import secrets
from oauth2client.client import flow_from_clientsecrets
from apiclient.discovery import build
from oauth2client.client import SignedJwtAssertionCredentials


class Driveback():
    def __init__(self, service_mail, private_key_path):
        self.service_mail = service_mail
        print service_mail
        self.private_key_path = private_key_path
        self.create_service()

    def __return_key(self):
        f = file(self.private_key_path, 'rb')
        key = f.read()
        f.close()
        return key

    def create_service(self):
        """Builds and returns a Drive service object authorized with the given service account.
        Returns:
        Drive service object.
        """
        key = self.__return_key()
        dict = {"access_type":"offline"}
        credentials = SignedJwtAssertionCredentials(self.service_mail, key,
          scope='https://www.googleapis.com/auth/drive')
        http = httplib2.Http()
        http = credentials.authorize(http)
        self.service = build('drive', 'v2', http=http)

    def upload(self, filename, mimetype='text/plain'):
        media_body = MediaFileUpload(filename, mimetype=mimetype, resumable=True)
        body = {
          'title': filename,
          'description': 'filename',
          'mimeType': 'application/x-tar-gz'
        }
        file_dict = self.service.files().insert(body=body, media_body=media_body).execute()
        pprint.pprint(file_dict)
        return file_dict

    def list(self):
        list_dict = self.service.files().list().execute()
        pprint.pprint(list_dict)
        return list_dict

    def delete(self, fileid):
        '''
        TODO: improve this, add try like in documenetaion
        '''
        del_dict = self.service.files().delete(fileId=fileid).execute()
        pprint.pprint(del_dict)

    def get_fileid():
        pass

if __name__ == "__main__":
    '''
    PLEASE REFERR TO: https://developers.google.com/drive/v2/reference/files
    '''
    drive = Driveback(open('mail.cfg', 'r').read().split('\n')[0], 'privatekey.key')
    
    drive.list()

