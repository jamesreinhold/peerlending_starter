from django.contrib.auth.base_user import BaseUserManager
from django.contrib.auth.models import AbstractUser
from django.db import models
from django.db.models import CharField
from django.urls import reverse
from django.utils.translation import gettext_lazy as _
import uuid


class UserManager(BaseUserManager):
    """Define a model manager for User model with no username field."""

    use_in_migrations = True

    def _create_user(self, email, password, **extra_fields):
        """Create and save a User with the given email and password."""
        if not email:
            raise ValueError(_('The given email must be set'))
        email = self.normalize_email(email)
        user = self.model(email=email, **extra_fields)
        user.set_password(password)
        user.save(using=self._db)
        return user

    def create_user(self, email, password=None, **extra_fields):
        """Create and save a regular User with the given email and password."""
        extra_fields.setdefault('is_staff', False)
        extra_fields.setdefault('is_superuser', False)
        return self._create_user(email, password, **extra_fields)

    def create_superuser(self, email, password, **extra_fields):
        """Create and save a SuperUser with the given email and password."""
        extra_fields.setdefault('is_staff', True)
        extra_fields.setdefault('is_superuser', True)

        if extra_fields.get('is_staff') is not True:
            raise ValueError(_('Superuser must have is_staff=True.'))
        if extra_fields.get('is_superuser') is not True:
            raise ValueError(_('Superuser must have is_superuser=True.'))

        return self._create_user(email, password, **extra_fields)


class User(AbstractUser):
    """Default user for P2P Lending."""

    #: First and last name do not cover name patterns around the globe
    objects = UserManager()

    name = CharField(_("Name of User"), blank=True, max_length=255)
    username = None
    USERNAME_FIELD = 'email'
    REQUIRED_FIELDS = []

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

    email = models.CharField(
        verbose_name=_('Email Address'),
        max_length=125,
        unique=True,
        help_text=_("Email address of the client."))

    def get_absolute_url(self):
        """Get url for user's detail view.

        Returns:
            str: URL for user detail.

        """
        return reverse("users:detail", kwargs={"username": self.id})
