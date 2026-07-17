# Security and Auditing: Protecting the Data Layer

- [Security and Auditing: Protecting the Data Layer](#security-and-auditing-protecting-the-data-layer)
  - [User and Role Management](#user-and-role-management)
    - [Users, Groups and Inheritance](#users-groups-and-inheritance)
    - [Role Attributes and Permissions](#role-attributes-and-permissions)
    - [Principles of Least Privilege (PoLP)](#principles-of-least-privilege-polp)
  - [Database Access Control](#database-access-control)
    - [Connection Authentication and Configuration](#connection-authentication-and-configuration)
    - [Granting and Revoking Permissions (`GRANT/REVOKE`)](#granting-and-revoking-permissions-grantrevoke)
  - [Row-Level Security (RLS) Policies](#row-level-security-rls-policies)
    - [Enabling and Defining RLS Policies](#enabling-and-defining-rls-policies)
    - [Bypassing RLS (The `BYPASSRLS` Pitfall)](#bypassing-rls-the-bypassrls-pitfall)
  - [Column-Level Security](#column-level-security)
    - [Masking Data on Retrieval](#masking-data-on-retrieval)
    - [Preventing Access to Sensitive Columns](#preventing-access-to-sensitive-columns)
  - [Data Protection](#data-protection)
    - [Encryption in Transit](#encryption-in-transit)
    - [Encryption at Rest](#encryption-at-rest)
  - [Logging Mechanisms](#logging-mechanisms)
    - [Standard PostgreSQL Logging Configuration (`log_statement`)](#standard-postgresql-logging-configuration-log_statement)
    - [Using External Audit Extensions (e.g., `pgaudit`)](#using-external-audit-extensions-eg-pgaudit)
    - [Centralized Log Management and Retention](#centralized-log-management-and-retention)





## User and Role Management
### Users, Groups and Inheritance
### Role Attributes and Permissions
### Principles of Least Privilege (PoLP)




## Database Access Control
### Connection Authentication and Configuration
- Client Authentication File (pg_hba.conf)
- Methods: md5, scram-sha-256, cert
- SSL/TLS: hostssl

### Granting and Revoking Permissions (`GRANT/REVOKE`)
- Default Permissions (ACL)






## Row-Level Security (RLS) Policies
### Enabling and Defining RLS Policies
- `USING`
- `WITH CHECK`
### Bypassing RLS (The `BYPASSRLS` Pitfall)




## Column-Level Security
### Masking Data on Retrieval
### Preventing Access to Sensitive Columns





## Data Protection
### Encryption in Transit
- Configuring SSL/TLS for Client Connections
- Enforcing Encryption (`hostssl`)



### Encryption at Rest
- Disk Encryption (e.g., LUKS, Cloud Service features)
- Application-Level Encryption vs. Database Encryption
- Hashing and Salting Sensitive Fields (e.g., Passwords)


## Logging Mechanisms
### Standard PostgreSQL Logging Configuration (`log_statement`)
### Using External Audit Extensions (e.g., `pgaudit`)
### Centralized Log Management and Retention