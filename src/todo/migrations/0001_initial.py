# Generated by Django 2.0.6 on 2018-06-11 18:56

from django.db import migrations, models


class Migration(migrations.Migration):

    initial = True

    dependencies = [
    ]

    operations = [
        migrations.CreateModel(
            name='TodoItem',
            fields=[
                ('id', models.AutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('title', models.CharField(blank=True, max_length=256, null=True)),
                ('completed', models.BooleanField(default=False)),
                ('url', models.CharField(default=False, max_length=256, null=True)),
                ('order', models.IntegerField(blank=True, null=True)),
            ],
        ),
    ]
