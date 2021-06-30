# -*- coding: utf-8 -*-

import github3
from os import getenv
import argparse
import json
import sys
import traceback


def get_installationid(app_installations, github_org):
    installation_id = -1

    if github_org == "":
        installation_id = next(app_installations).id
    else:
        for installation in app_installations:
            data = installation.as_dict()

            if data["account"]["login"] == github_org:
                installation_id = installation.id
    return installation_id


def get_token(github_app_id, github_app_key, github_org):
    try:
        GITHUB_PRIVATE_KEY = getenv("GITHUB_PRIVATE_KEY", github_app_key)

        GITHUB_APP_IDENTIFIER = getenv("GITHUB_APP_IDENTIFIER", github_app_id)

        gh = github3.github.GitHub()

        # Login as app
        gh.login_as_app(GITHUB_PRIVATE_KEY.encode(), GITHUB_APP_IDENTIFIER)

        # Login to the installation, assuming only a single one
        installation_id = get_installationid(
            gh.app_installations(), github_org
        )
        if installation_id == -1:
            raise Exception("The githubapp is not installed on the org")

        gh.login_as_app_installation(
            GITHUB_PRIVATE_KEY.encode(),
            GITHUB_APP_IDENTIFIER,
            installation_id,
        )
        # or access token to checkout the repository
        return (0, gh.session.auth.token)
    except Exception as error:
        print("Error: " + str(error))
        return (1, str(error))


if __name__ == "__main__":
    parser = argparse.ArgumentParser(
        description="Get installation token from Githubapp"
    )
    parser.add_argument(
        "--github-app-id",
        dest="github_app_id",
        type=str,
        help="Github app ID",
        default="111111",
        required=False,
    )
    parser.add_argument(
        "--github-app-key",
        dest="github_app_key",
        type=str,
        help="Github app public key",
        default="kajsdflkasjdflñaksjdflkajdf",
        required=False,
    )
    parser.add_argument(
        "--github-organization",
        dest="github_org",
        type=str,
        help="Github app organization",
        default="",
        required=False,
    )
    args = parser.parse_args()

    output = get_token(
        args.github_app_id, args.github_app_key, args.github_org
    )

    print("::set-output name=token::" + output[1])
    sys.exit(output[0])  # code 0, all ok
