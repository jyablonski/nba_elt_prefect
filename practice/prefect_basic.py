from prefect import task, flow

import requests

@task
def extract_url_content(url, params=None):
    return requests.get(url, params=params).content


@task
def is_trending(trending_page, repo="prefect"):
    is_trending = repo.encode() in trending_page
    is_phrase = 'not ' if not is_trending else ' '
    print(f"{repo} is {is_phrase}trending.", "\n")
    return is_trending


@flow
def repo_trending_check(url="https://github.com/trending/python", 
                        window="daily"):
    content = extract_url_content(url, params={"since": window})
    return is_trending(content)

state = repo_trending_check()

# do prefect orion start
# python3 -m prefect_basic