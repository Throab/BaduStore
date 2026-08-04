using System.Globalization;
using System.Text.RegularExpressions;
using System.Text;

namespace Service.Utils
{
    public class DataHelper
    {
        public static string ToAlias(string text)
        {
            if (string.IsNullOrWhiteSpace(text))
                return string.Empty;
            text = text.Normalize(NormalizationForm.FormD);
            StringBuilder sb = new();
            foreach (char c in text)
            {
                UnicodeCategory uc = CharUnicodeInfo.GetUnicodeCategory(c);
                if (uc != UnicodeCategory.NonSpacingMark)
                {
                    sb.Append(c);
                }
            }
            text = sb.ToString().Normalize(NormalizationForm.FormC);
            text = text.Replace('đ', 'd').Replace('Đ', 'D');
            text = text.ToLowerInvariant();
            text = Regex.Replace(text, @"\s+", "-");
            text = Regex.Replace(text, @"[^a-z0-9\-]", "");
            text = Regex.Replace(text, @"-+", "-");
            text = text.Trim('-');
            return text;
        }
    }
}
