# system-monitoring-2.0
project3-system-monitroing(process &amp; port monitoring) and alerting via Gmail
# System Monitor

Lightweight bash script for monitoring system resources with email alerting.

## Features

- **Disk Usage**: Monitors all mounted filesystems
- **Memory Usage**: Tracks RAM utilization
- **Process Monitoring**: Shows top CPU/memory consumers
- **Email Alerts**: Gmail SMTP notifications
- **Logging**: Timestamped alerts to file

## Quick Start

```bash
# Configure email settings
vim system_monitor.sh  # Update EMAIL and EMAIL_PASSWORD

# Install dependencies
sudo apt-get install mailutils

# Run monitoring
./system_monitor.sh
```

## Configuration

| Variable | Default | Description |
|----------|---------|-------------|
| `DISK_THRESHOLD` | 80 | Disk usage alert threshold (%) |
| `MEMORY_THRESHOLD` | 80 | Memory usage alert threshold (%) |
| `LOG_FILE` | `/var/log/system_monitor.log` | Alert log location |
| `EMAIL` | - | Gmail address for alerts |
| `EMAIL_PASSWORD` | - | Gmail app password |

## Gmail Setup

1. Enable 2FA on Gmail account
2. Generate app password: Settings → Security → App passwords
3. Configure `/etc/ssmtp/ssmtp.conf`:

```
root=your-email@gmail.com
mailhub=smtp.gmail.com:587
AuthUser=your-email@gmail.com
AuthPass=your-app-password
UseSTARTTLS=YES
```

## Deployment

```bash
# Cron job for continuous monitoring
echo "*/5 * * * * /path/to/system_monitor.sh" | crontab -

# Systemd service
sudo cp system_monitor.service /etc/systemd/system/
sudo systemctl enable --now system_monitor
```

## Output

- **Console**: Real-time alerts and process lists
- **Log**: `/var/log/system_monitor.log`
- **Email**: Threshold breach notifications

## Requirements

- Bash 4.0+
- mailutils package
- Gmail account with app password
