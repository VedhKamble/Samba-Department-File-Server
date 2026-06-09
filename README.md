# Samba Department File Server

A Linux based Samba file server implementing department-wise
role based access control between Linux server and Windows clients.

## Project Objective

The goal of this project was to build a small organization-style
file server where different departments have isolated shared storage.

# Samba Server Architecture

```
                 Windows Client Machine
                         |
                         |
                         |  SMB / CIFS Protocol
                         |
                         |
                 Linux Samba Server
                         |
        ---------------------------------
        |              |                |
        |              |                |
   Finance Share   Accounts Share    HR Share
        |              |                |
 finance group    accounts group     hrd group
        |              |                |
  john,richa      anjali,rahul     richa,anjali


                         |
                    Public Share
                         |
                  Accessible Users
```

## Components

### Linux Samba Server

Responsible for:

* Hosting shared directories
* User authentication
* Permission management
* SMB communication with clients

### Windows Client

Used for:

* Connecting to Samba shares
* Testing user authentication
* Verifying access permissions

## Share Structure

```
/Finance
   |
   +-- Finance department files


/Accounts
   |
   +-- Accounts department files


/HRD
   |
   +-- HR department files


/Public
   |
   +-- Common files for all users


/Dropbox
   |
   +-- Upload-only shared area
```

## Security Model

Access control is implemented using multiple layers:

1. Linux users and groups

2. Linux filesystem permissions

3. Samba authentication

4. Samba share restrictions

5. SELinux Samba policies

## User Access Flow

```
User Login
     |
     |
Samba Authentication
     |
     |
Check Share Permissions
     |
     |
Check Linux File Permissions
     |
     |
Allow / Deny Access
```

## Technologies Used

* RHEL Linux
* Samba Server
* SMB/CIFS Protocol
* SELinux
* FirewallD
* Windows File Explorer



## Implemented Features

- Samba authentication
- Linux users integrated with Samba
- Department based groups
- Restricted shares
- Public share
- Read/write permissions
- Windows client access
- SELinux configuration
- Firewall configuration


 Documentation/testing.md
# Testing Report

## Samba User Verification
Command:
pdbedit -L

Result stored:
outputs/samba-users.txt

## Share Discovery Test
Command:
smbclient -L server-ip

Result:
outputs/windows-client-share-list.txt


Detected shares:
- Finance
- Accounts
- HR
- Public
- Dropbox

## Permission Testing
Filesystem permissions checked using:
ls -ld /Accounts
ls -ld /Finance
ls -ld /HRD

Output:
outputs/share-permissions.txt


Access is controlled using:

- Linux ownership
- Linux groups
- Samba valid users
- Samba write permissions

## Testing Evidence

The outputs directory contains:
- Samba users
- Linux groups
- Directory permissions
- SMB client share discovery


## Setup

Run:
chmod +x scripts/setup.sh
./scripts/setup.sh

Then place smb.conf:
/etc/samba/smb.conf

Restart:
systemctl restart smb


## Future Improvements

- Samba AD Domain Controller
- Backup automation
- Audit logging
- Web management panel
- User quota management
