export class DateUtils {

  dateFormat(date: Date): string {
    const customOptions: Intl.DateTimeFormatOptions = {
      year: 'numeric',
      month: '2-digit',
      day: '2-digit',
      // hour: '2-digit',
      // minute: '2-digit',
      // hour12: false // 24小时制
    };
    const customFormatter = new Intl.DateTimeFormat('zh-CN', customOptions);
    console.log(customFormatter.format(date)); // "2024/07/08 14:30"
    return customFormatter.format(date)
  }
}