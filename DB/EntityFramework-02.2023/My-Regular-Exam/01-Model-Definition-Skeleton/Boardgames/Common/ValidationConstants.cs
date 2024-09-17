using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Boardgames.Common
{
    public static class ValidationConstants
    {
        //Boardgame
        public const int BoardgameNameMaxLength = 20;

        //Seller
        public const string WebsiteRegex = @"www\.[a-zA-Z0-9-]*\.com";
    }
}
