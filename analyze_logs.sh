#!/bin/bash

LOG_FILE="access.log"
REPORT_FILE="report.txt"

# Подсчет общего количества запросов
total_quantity_requests=$(wc -l < "$LOG_FILE")

# Подсчет уникальных IP-адресов с использованием awk
unique_ips=$(awk '{print $1}' "$LOG_FILE" | sort | uniq | wc -l)

# Подсчет количества запросов по методам
methods=$(awk -F\" '{print $2}' "$LOG_FILE" | awk '{print $1}' | sort | uniq -c)

# Самый популярный URL
popular_url=$(awk -F\" '{print $2}' "$LOG_FILE" | awk '{print $2}' | sort | uniq -c | sort -nr | head -1)

# Сохраняем отчет
{
  echo "Отчет о логе веб-сервера:"
  echo "========================"
  echo "Общее количество запросов:        $total_quantity_requests"
  echo "Количество уникальных IP-адресов:            $unique_ips"
  echo ""
  echo "Количество запросов по методам:"
  echo "$methods"
  echo ""
  echo "Самый популярный URL:     $popular_url" 
  } > "$REPORT_FILE"

echo "Отчет сохранен в файл $REPORT_FILE"
