from django.contrib.auth.models import AbstractUser
from django.db import models
from django.db.models import CharField
from django.urls import reverse
from django.utils.translation import gettext_lazy as _
import uuid


class User(AbstractUser):
    """Default user for P2P Lending."""

    #: First and last name do not cover name patterns around the globe
    name = CharField(_("Name of User"), blank=True, max_length=255)

    id = models.UUIDField(
        primary_key=True,
        default=uuid.uuid4,
        editable=False,
        help_text=_("""The unique identifier of the instance this object belongs to.
                    Mandatory, unless a new instance to create is given."""))

    first_name = models.CharField(
        verbose_name=_('First names'),
        max_length=125,
        blank=True, null=True,
        help_text=_("Legal First names of the client."))

    last_name = models.CharField(
        verbose_name=_('Last names'),
        max_length=125,
        blank=True, null=True,
        help_text=_("Legal Last names of the client."))

    def get_absolute_url(self):
        """Get url for user's detail view.

        Returns:
            str: URL for user detail.

        """
        return reverse("users:detail", kwargs={"username": self.id})
