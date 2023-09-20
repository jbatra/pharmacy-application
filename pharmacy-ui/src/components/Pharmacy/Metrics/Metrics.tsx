import { BarChart } from "@mui/x-charts";
import { axisClasses } from '@mui/x-charts';

    const dataset = [
        {
        'Bartell Drugs #763': 18411.0,
        'CVS #542':15270.00,
        'Kroger #307': 20142.00,
        month: 'Sept'}
    
    ];

    const chartSetting = {
        yAxis: [
          {
            label: 'Sales Amount ($)',
          },
        ],
        width: 300,
        height: 300,
        sx: {
          [`.${axisClasses.left} .${axisClasses.label}`]: {
            transform: 'rotate(-90deg) translate(0px, -5px)',
          },
        },
      };

 const Matrix = () => {
    


    return ( 
        <BarChart
        dataset={dataset}
        xAxis={[{ scaleType: 'band', dataKey: 'month' }]}
        series={[
          { dataKey: 'Bartell Drugs #763', label: 'Bartell Drugs #763' },
          { dataKey: 'CVS #542', label: 'CVS #542' },
          { dataKey: 'Kroger #307', label: 'Kroger #307' },
        ]}
        {...chartSetting}
      />
        )
    
}

export default Matrix