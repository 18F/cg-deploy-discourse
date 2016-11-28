# 18F Discourse discussion community deployment

This repo contains the [Concourse](https://concourse.ci/) pipeline for deploying [Discourse](https://www.discourse.org/) discussion community for [cloud.gov](https://cloud.gov).

## Login

To set up login via OAuth:

1. Create UAA client:

    ```bash
    uaac client add cloud-gov-community \
        --authorities uaa.none \
        --authorized_grant_types refresh_token,authorization_code \
        --redirect-uri https://community.fr.cloud.gov/auth/oauth2_basic/callback \
        --scope openid
    ```

1. Configure OAuth on discourse: https://github.com/discourse/discourse-oauth2-basic#part-1-basic-configuration
