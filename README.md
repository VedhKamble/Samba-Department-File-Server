# Samba Department File Server

A Linux based Samba file server implementing department-wise
role based access control between Linux server and Windows clients.

## Project Objective

The goal of this project was to build a small organization-style
file server where different departments have isolated shared storage.


## Architecture

Windows Client
|
| SMB Protocol
|
Linux Samba Server
|
+---- Finance Share
|
+---- Accounts Share
|
+---- HR Share
|
+---- Public Share
|
+---- Dropbox Share


## Technologies Used

- RHEL Linux
- Samba
- SMB/CIFS
- SELinux
- FirewallD
- Windows File Explorer


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


## Users

| User | Department |
|-|-|
| john | Accounts |
| rahul | Finance |
| anjali | Accounts |
| richa | Finance + HR |
| vedh | Administrator |


## Shares

| Share | Access |
|-|-|
| Finance | Finance group |
| Accounts | Accounts group |
| HR | HR group |
| Public | Everyone |
| Dropbox | Upload area |


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
2. documentation/users-groups.md
# Users and Groups

The server uses Linux groups to control Samba access.

Groups:

finance
accounts
hrd


Example:

finance:
- richa
- john


accounts:
- anjali
- rahul


hrd:
- richa
- anjali


The output files proving this configuration are stored in:

outputs/linux-groups.txt


3. documentation/testing.md
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

4. documentation/architecture.md
# Architecture


                  Windows Client

                         |
                         |
                         | SMB

                         |

                 Samba Server

                         |

        +----------------+----------------+

        |                |                |

     Finance          Accounts          HR

        |                |                |

   finance grp     accounts grp      hrd grp


Access is controlled using:

- Linux ownership
- Linux groups
- Samba valid users
- Samba write permissions
