// var a1 = [1, 2, 3];
// var a2 = [1, 2, 3];
//var b;// = [[1,2,3,4],[1,2,3,4]];

// // array_compare(a1, a2);
// array_compare(b);

// function array_compare(b) {
//     a1 = b[0];
//     a2 = b[1];
//     a3 = b[2];
//     a4 = b[3];
//     a5 = b[4];
//     a6 = b[5];
//     a7 = b[6];
//     if(a1.length != a2.length) {
//      return false;
//     }
//     for(var i in a1) {
//      // Don't forget to check for arrays in our arrays.
//      if(a1[i] instanceof Array && a2[i] instanceof Array && instanceof Array a3[i] && instanceof Array a4[i] && instanceof Array a5[i] && instanceof Array a6[i] && instanceof Array a7[i])  {
//       if(!array_compare(a1[i], a2[i], a3[i], a4[i], a5[i], a6[i], a7[i])) {
//        return false; 
//       }
//      }
//      else if(a1[i] != a2[i] && a3[i] && a4[i] && a5[i] && a6[i] && a7[i]) {
//       return false;
//      }
//     }
//     return true;
//    }

// function array_compare(a1, a2) {
//  if(a1.length != a2.length) {
//   return false;
//  }
//  for(var i in a1) {
//   // Don't forget to check for arrays in our arrays.
//   if(a1[i] instanceof Array && a2[i] instanceof Array) {
//    if(!array_compare(a1[i], a2[i])) {
//     return false;
//    }
//   }
//   else if(a1[i] != a2[i]) {
//    return false;
//   }
//  }
//  return true;
// }
