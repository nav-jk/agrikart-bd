# Generated by Django 5.1.7 on 2025-06-21 19:06

from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ("buyer", "0005_order_buyer_lat_order_buyer_lon_order_farmer_lat_and_more"),
    ]

    operations = [
        migrations.AddField(
            model_name="buyer",
            name="latitude",
            field=models.FloatField(blank=True, null=True),
        ),
        migrations.AddField(
            model_name="buyer",
            name="longitude",
            field=models.FloatField(blank=True, null=True),
        ),
    ]
