from django.apps import AppConfig
from django.utils.translation import gettext_lazy as _


class UsersConfig(AppConfig):
    name = "peer_lending.users"
    verbose_name = _("Users")

    def ready(self):
        try:
            import peer_lending.users.signals  # noqa F401
        except ImportError:
            pass
