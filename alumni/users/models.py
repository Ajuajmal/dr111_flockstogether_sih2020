from django.contrib.auth.models import AbstractUser
from django.db.models import CharField
from django.db import models
from django.urls import reverse
from django.utils.translation import gettext_lazy as _

from django.core.validators import MaxValueValidator, MinValueValidator, RegexValidator

phone_number_regex = RegexValidator(
    regex=r"^((\+91|91|0)[\- ]{0,1})?[456789]\d{9}$",
    message="Please Enter 10/11 digit mobile number or landline as 0<std code><phone number>",
    code="invalid_mobile",
)


class User(AbstractUser):
    """Default user for Alumni Tracker.
    """
    TYPE_VALUE_MAP = {
        "Alumni": 5,
        "AlumniStaff": 10,
        "Staff": 15,
        "College": 20,
        "CollegeAdmin": 25,
        "Directorate" : 30,
        "Def" : 0,
    }
    TYPE_CHOICES = [(value, name) for name, value in TYPE_VALUE_MAP.items()]
    user_type = models.IntegerField(choices=TYPE_CHOICES, blank=True, default=0)
    phone_number = models.CharField(max_length=14, validators=[phone_number_regex],blank=True,default=1234567890)

    #: First and last name do not cover name patterns around the globe
    name = CharField(_("Name of User"), blank=True, max_length=255)

    def get_absolute_url(self):
        """Get url for user's detail view.

        Returns:
            str: URL for user detail.

        """
        return reverse("users:detail", kwargs={"username": self.username})
