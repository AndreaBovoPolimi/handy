const math = require('mathjs');

// rows => eventCategories
// columns => university Departments
exports.similarityMatrix = [
  [0.64513, 0.52983, 0.3214, 0.88462, 0.79077, 0.58434, 0.76878, 0.82788, 0.9953, 0.43399],
  [0.80531, 0.95544, 0.95107, 0.86036, 0.60596, 0.34258, 0.32559, 0.14872, 0.00466, 0.3079],
  [0.04154, 0.37685, 0.71013, 0.99985, 0.99782, 0.36329, 0.20522, 0.86719, 0.838, 0.58338],
  [0.18185, 0.39784, 0.18848, 0.99859, 0.50312, 0.93105, 0.4252, 0.31402, 0.63819, 0.56574],
  [0.46927, 0.20975, 0.97993, 0.64695, 0.91199, 0.53993, 0.12632, 0.27515, 0.49137, 0.64871],
];

exports.eventCategories = ['music', 'sport', 'workshop', 'conference', 'roundtable'];

exports.universityDepartments = [
  'Computer Science Engineering',
  'Aeronautical Engineering',
  'Architecture',
  'Chemical Engineering',
  'Management Engineering',
  'Mechanical Engineering',
  'Interior Design',
  'Biomedical Engineering',
  'Civil Engineering',
  'Digital and interaction design',
];

exports.getSortedCategoriesByDepartment = (departmentString) => {
  const transposed = math.transpose(this.similarityMatrix);

  departmentIndex = this.universityDepartments.indexOf(departmentString);

  console.log(departmentIndex);

  values = Object.entries(Object.assign({}, transposed[departmentIndex]));
  values.sort((el, el2) => (el[1] < el2[1] ? 1 : -1));
  values = values.map((el) => [this.eventCategories[el[0]], el[1]]);
  values = Object.fromEntries(values);

  return values;
};
