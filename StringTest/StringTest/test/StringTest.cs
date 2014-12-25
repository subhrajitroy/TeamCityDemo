using Microsoft.VisualStudio.TestTools.UnitTesting;

namespace StringTest.test
{
    [TestClass]
    public class StringTest
    {
        [TestMethod]
        public void ShouldAddUnderscoreToString()
        {
            Assert.AreEqual("_test","test".Underscore());
        }
    }
}