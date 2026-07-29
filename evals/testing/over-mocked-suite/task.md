Apply the /testing skill. Review this test file. Coverage on the module is 97%
and the team is proud of it, but we shipped two bugs in this code last quarter.

```python
def test_create_user_calls_repository():
    repo = Mock()
    hasher = Mock()
    hasher.hash.return_value = "hashed"
    svc = UserService(repo, hasher)

    svc.create_user("a@b.com", "pw123")

    repo.insert.assert_called_once()
    hasher.hash.assert_called_once_with("pw123")


def test_create_user_calls_hasher_before_repository():
    manager = Mock()
    repo, hasher = Mock(), Mock()
    manager.attach_mock(hasher, "hasher")
    manager.attach_mock(repo, "repo")
    svc = UserService(repo, hasher)

    svc.create_user("a@b.com", "pw123")

    assert manager.mock_calls[0][0] == "hasher.hash"


def test_create_user_returns_repo_result():
    repo = Mock()
    repo.insert.return_value = sentinel.user
    svc = UserService(repo, Mock())
    assert svc.create_user("a@b.com", "pw123") is sentinel.user


def test_create_user_does_not_raise():
    svc = UserService(Mock(), Mock())
    svc.create_user("a@b.com", "pw123")
```

The two bugs we shipped: duplicate emails were accepted, and passwords under
8 characters were accepted.
