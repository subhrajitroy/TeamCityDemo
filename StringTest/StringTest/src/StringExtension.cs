namespace StringTest
{
    public static class StringExtension
    {
        public static string Underscore(this string value)
        {
            return string.Format("_{0}", value);
        }
    }
}